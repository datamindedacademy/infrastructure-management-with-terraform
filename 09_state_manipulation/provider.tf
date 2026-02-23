terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  // TO DO: change $yourname by your own name!
  backend "s3" {
    bucket  = "better-infrastructure-management-with-terraform"
    key     = "state_manipulation/$yourname/terraform.tfstate"
    region  = "eu-west-1"
    profile = "academy"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "academy"
  assume_role {
    role_arn = "arn:aws:iam::338791806049:role/exercise_09_role"
  }
}

