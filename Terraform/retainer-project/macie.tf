# Amazon Macie Configuration

# Enable Amazon Macie

resource "aws_macie2_account" "this" {
  status = "ENABLED"

  finding_publishing_frequency = "FIFTEEN_MINUTES"

  tags = {
    Name        = "${var.project_name}-macie"
    Environment = var.environment
  }
}

# Macie Classification Job
resource "aws_macie2_classification_job" "sensitive_data_scan" {

  job_type = "SCHEDULED"

  name = "${var.project_name}-scan"

  s3_job_definition {

    bucket_definitions {
      account_id = data.aws_caller_identity.current.account_id
      buckets    = [aws_s3_bucket.source_bucket.id]
    }

    scoping {
      excludes {
        and {
          simple_scope_term {
            comparator = "EQ"

            key = "OBJECT_EXTENSION"

            values = [
              "jpg",
              "jpeg",
              "png",
              "gif"
            ]
          }
        }
      }
    }
  }

  depends_on = [
    aws_macie2_account.this
  ]
}