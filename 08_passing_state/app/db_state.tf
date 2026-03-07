data "terraform_remote_state" "db_state" {
  backend = "s3"
  config = {
    bucket = "better-infrastructure-management-with-terraform"
    key    = "passing_state/db/terraform.tfstate"
    region = "eu-west-1"
  }
}