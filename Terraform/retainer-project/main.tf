# Sensitive Data Retention Project

locals {
  project_name = "sensitive-data-retention"

  common_tags = {
    Project     = local.project_name
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}