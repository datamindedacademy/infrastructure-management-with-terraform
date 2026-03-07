data "aws_ssm_parameter" "db_address" {
  name = "/terraform_workshop/passing_state/${var.student_name}/db_address"
}

data "aws_ssm_parameter" "db_port" {
  name = "/terraform_workshop/passing_state/${var.student_name}/db_port"
}