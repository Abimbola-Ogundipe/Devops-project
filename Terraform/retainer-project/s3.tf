# S3 Configuration


# Source S3 Bucket

resource "aws_s3_bucket" "source_bucket" {
  bucket = var.source_bucket_name

  tags = {
    Name        = "${var.project_name}-source"
    Environment = var.environment
  }
}


# Quarantine S3 Bucket

resource "aws_s3_bucket" "quarantine_bucket" {
  bucket = var.quarantine_bucket_name

  tags = {
    Name        = "${var.project_name}-quarantine"
    Environment = var.environment
  }
}


# Enable Versioning on Source Bucket

resource "aws_s3_bucket_versioning" "source_versioning" {
  bucket = aws_s3_bucket.source_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


# Enable Versioning on Quarantine Bucket

resource "aws_s3_bucket_versioning" "quarantine_versioning" {
  bucket = aws_s3_bucket.quarantine_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


# Source Bucket Encryption

resource "aws_s3_bucket_server_side_encryption_configuration" "source_encryption" {
  bucket = aws_s3_bucket.source_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Quarantine Bucket Encryption

resource "aws_s3_bucket_server_side_encryption_configuration" "quarantine_encryption" {
  bucket = aws_s3_bucket.quarantine_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Block Public Access to Source Bucket

resource "aws_s3_bucket_public_access_block" "source_public_access" {
  bucket = aws_s3_bucket.source_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}


# Block Public Access to Quarantine Bucket

resource "aws_s3_bucket_public_access_block" "quarantine_public_access" {
  bucket = aws_s3_bucket.quarantine_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}


# Source Bucket Ownership

resource "aws_s3_bucket_ownership_controls" "source_ownership" {
  bucket = aws_s3_bucket.source_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


# Quarantine Bucket Ownership

resource "aws_s3_bucket_ownership_controls" "quarantine_ownership" {
  bucket = aws_s3_bucket.quarantine_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}