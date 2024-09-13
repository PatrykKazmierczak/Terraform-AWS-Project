
# Specify the minimum version of Terraform required for this configuration
terraform {
  required_version = "1.9.5"


# Define the required providers and their versions
required_providers {
  aws = {
    source  = "hashicorp/aws"  # Provider source from HashiCorp
    version = "5.66.0"         # Exact version of the AWS provider required
  }
}

# Configure the backend to store the Terraform state file
backend "s3" {
  bucket         = "terraform-videopoint-state-backup"  # S3 bucket name where the state file will be stored
  key            = "terraform.tfstate"                  # Path within the S3 bucket for the state file
  region         = "eu-north-1"                         # AWS region where the S3 bucket is located
  dynamodb_table = "terraform-videopoint"                # DynamoDB table for state locking and consistency checking
}

# Configure the AWS provider
provider "aws" {
  region = "eu-north-1"  # AWS region where resources will be created
}
