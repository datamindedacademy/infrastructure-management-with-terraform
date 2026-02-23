terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "academy"
  assume_role {
    role_arn = "arn:aws:iam::338791806049:role/exercise_01_role"
  }
}

