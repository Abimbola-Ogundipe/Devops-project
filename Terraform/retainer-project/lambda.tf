# AWS Lambda Configuration

# Archive Lambda Function
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_retention_function.py"
  output_path = "${path.module}/lambda/lambda_retention_function.zip"
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}