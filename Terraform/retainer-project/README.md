## The main.tf file acts as the entry point of your Terraform configuration. The idea is to separate resources into different files, main.tf doesn't need to contain every resource. It simply ties the project together. Such that, Terraform automatically loads all .tf files in the same directory. 

## The versions.tf file specifies: The minimum Terraform version required (version = "~> 6.0") and AWS as the provider (source = "hashicorp/aws").

## he provider.tf file tells Terraform which cloud provider to use and which AWS Region to deploy your resources into.Instead of hardcoding the region (for example, eu-west-2 or us-east-1), I use a variable for reusability.

## 