terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    // TO DO: configure this correctly after setting up the remote backend
    profile  = "academy"
    role_arn = "arn:aws:iam::338791806049:role/exercise_02_role"

  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "academy"
  assume_role {
    role_arn = "arn:aws:iam::338791806049:role/exercise_02_role"
  }
}


