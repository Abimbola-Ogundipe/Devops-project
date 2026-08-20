# IAM Role and Policies for Lambda

# Lambda IAM Role

resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}


# Lambda IAM Policy

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.project_name}-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      # Read objects from the source S3 bucket
      {
        Sid    = "ReadSourceBucket"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]

        Resource = [
          aws_s3_bucket.source_bucket.arn,
          "${aws_s3_bucket.source_bucket.arn}/*"
        ]
      },

      # Copy sensitive objects to the quarantine bucket
      {
        Sid    = "WriteToQuarantineBucket"
        Effect = "Allow"

        Action = [
          "s3:PutObject"
        ]

        Resource = [
          "${aws_s3_bucket.quarantine_bucket.arn}/*"
        ]
      },

      # CloudWatch logging
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      },

      # Read Macie findings
      {
        Sid    = "MacieFindings"
        Effect = "Allow"

        Action = [
          "macie2:GetFindings",
          "macie2:ListFindings"
        ]

        Resource = "*"
      }
    ]
  })
}


# Attach IAM Policy to Lambda Role

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}