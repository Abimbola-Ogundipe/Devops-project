# Enable Amazon Macie
resource "aws_macie2_account" "this" {
  status = "ENABLED"
  finding_publishing_frequency = "FIFTEEN_MINUTES"
}


# Custom Data Identifier
resource "aws_macie2_custom_data_identifier" "test_sensitive_data" {

  name = "${var.project_name}-custom-sensitive-data"
  description = "Detects project test sensitive data"

  regex = "SENSITIVE-[0-9]{6}"

  keywords = [
    "Customer ID"
  ]

  maximum_match_distance = 50

  depends_on = [
    aws_macie2_account.this
  ]
}


# One-Time Classification Job
resource "aws_macie2_classification_job" "sensitive_data_scan" {

  job_type = "ONE_TIME"

  name = "${var.project_name}-scan-test-6"

  custom_data_identifier_ids = [
    aws_macie2_custom_data_identifier.test_sensitive_data.id
  ]

  sampling_percentage = 100

  s3_job_definition {

    bucket_definitions {
      account_id = data.aws_caller_identity.current.account_id

      buckets = [
        aws_s3_bucket.source_bucket.bucket
      ]
    }

    scoping {
      excludes {
        and {
          simple_scope_term {
            comparator = "EQ"
            key        = "OBJECT_EXTENSION"

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
    aws_macie2_account.this,
    aws_macie2_custom_data_identifier.test_sensitive_data
  ]
}