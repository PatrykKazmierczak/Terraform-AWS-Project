terraform {
  required_version = "1.9.5"


  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket = "terraform-videopoint-state-backup"
    key = "terraform.tfstate"
    region = "eu-north-1"
    dynamodb_table = "terraform-videopoint"
  }
}

provider "aws" {
    region = "eu-north-1"
}
