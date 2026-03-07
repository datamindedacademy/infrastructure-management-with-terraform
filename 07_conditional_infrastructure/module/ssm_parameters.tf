
data "aws_ssm_parameter" "vpc_id" {
  name = "/terraform_workshop/notebook_vpc_id"
}

data "aws_ssm_parameter" "iam_role" {
  name = "/terraform_workshop/notebook_role"
}

data "aws_ssm_parameter" "subnet_id" {
  name = "/terraform_workshop/notebook_subnet_id"
}

data "aws_ssm_parameter" "security_group_id" {
  name = "/terraform_workshop/security_group_id"
}