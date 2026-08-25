# Terraform Outputs

output "source_bucket_name" {
  description = "Name of the S3 source bucket."
  value       = aws_s3_bucket.source_bucket.bucket
}

output "source_bucket_arn" {
  description = "ARN of the S3 source bucket."
  value       = aws_s3_bucket.source_bucket.arn
}

output "quarantine_bucket_name" {
  description = "Name of the quarantine S3 bucket."
  value       = aws_s3_bucket.quarantine_bucket.bucket
}

output "quarantine_bucket_arn" {
  description = "ARN of the quarantine S3 bucket."
  value       = aws_s3_bucket.quarantine_bucket.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.scanner.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.scanner.arn
}

output "lambda_role_arn" {
  description = "ARN of the Lambda IAM role."
  value       = aws_iam_role.lambda_role.arn
}

output "retention_period_days" {
  description = "Number of days sensitive data is retained."
  value       = var.retention_days
}