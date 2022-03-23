terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket  = "better-infrastructure-management-with-terraform"
    key     = "cicd/terraform.tfstate"
    encrypt = "true"
  }
}

# Configure the AWS Provider
provider "aws" {}