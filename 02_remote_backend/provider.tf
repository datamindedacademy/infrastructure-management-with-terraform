terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
  backend "s3" {
    // TO DO: configure this correctly after setting up the remote backend
    profile  = "academy"
    role_arn = "arn:aws:iam::338791806049:role/exercise_02_role"
    bucket   = "better-infrastructure-management-with-terraform-117"
    key      = "terraform/02_remote_backend/state.tfstate"
    region   = "eu-west-1"
    dynamodb_table = "terraform-training-lock-11"
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


