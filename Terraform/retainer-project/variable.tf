# variables.tf

variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "sensitive-data-retention"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "source_bucket_name" {
  description = "S3 bucket where users upload their files"
  type        = string
  default     = "abi2-sensitive-data-source-bucket"
}

variable "quarantine_bucket_name" {
  description = "S3 bucket used to store sensitive files before permanent deletion."
  type        = string
  default     = "abi2-sensitive-data-quarantine-bucket"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "sensitive-data-scanner"
}

variable "retention_days" {
  description = "Number of days sensitive files should be retained"
  type        = number
  default     = 30
}