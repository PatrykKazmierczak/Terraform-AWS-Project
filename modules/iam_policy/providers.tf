# Specify the minimum version of Terraform required for this configuration
terraform {
  required_version = "1.9.5" # Terraform version 1.9.5 or higher is required

  # Define the required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Provider source from HashiCorp
      version = "5.67.0"        # Exact version of the AWS provider required
    }
  }
}
