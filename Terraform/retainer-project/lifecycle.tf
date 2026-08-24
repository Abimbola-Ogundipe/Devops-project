# S3 Lifecycle Configuration

resource "aws_s3_bucket_lifecycle_configuration" "quarantine_lifecycle" {
  bucket = aws_s3_bucket.quarantine_bucket.id

  rule {
    id     = "delete-after-retention-period"
    status = "Enabled"

    expiration {
      days = var.retention_days #instead of hardcoding
    }

    noncurrent_version_expiration {
      noncurrent_days = var.retention_days
    }
  }
}