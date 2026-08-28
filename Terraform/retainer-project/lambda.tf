# Archive Lambda Function

data "archive_file" "lambda_zip" {
  type = "zip"

  source_file = "${path.module}/lambda/lambda_retention_function.py"

  output_path = "${path.module}/lambda/lambda_retention_function.zip"
}


# CloudWatch Log Group

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name = "/aws/lambda/${var.lambda_function_name}"

  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}


# Lambda Function

resource "aws_lambda_function" "scanner" {

  function_name = var.lambda_function_name

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role = aws_iam_role.lambda_role.arn

  handler = "lambda_retention_function.lambda_handler"

  runtime = "python3.12"

  timeout = 60

  memory_size = 256

  environment {
    variables = {
      SOURCE_BUCKET     = aws_s3_bucket.source_bucket.bucket
      QUARANTINE_BUCKET = aws_s3_bucket.quarantine_bucket.bucket
      RETENTION_DAYS    = var.retention_days
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.lambda_logs
  ]

  tags = {
    Environment = var.environment
  }
}


# CloudWatch schedule to check Macie findings

resource "aws_cloudwatch_event_rule" "macie_check" {

  name = "${var.project_name}-macie-check"

  description = "Check Macie findings every 15 minutes"

  schedule_expression = "rate(15 minutes)"
}


# Allow CloudWatch to invoke Lambda

resource "aws_lambda_permission" "allow_cloudwatch" {

  statement_id = "AllowExecutionFromCloudWatch"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.scanner.function_name

  principal = "events.amazonaws.com"

  source_arn = aws_cloudwatch_event_rule.macie_check.arn
}


# Connect CloudWatch schedule to Lambda

resource "aws_cloudwatch_event_target" "lambda" {

  rule = aws_cloudwatch_event_rule.macie_check.name

  target_id = "MacieCheckLambda"

  arn = aws_lambda_function.scanner.arn
}