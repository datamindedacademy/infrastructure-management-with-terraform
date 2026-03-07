resource "aws_ssm_parameter" "db_address" {
  name  = "/terraform_workshop/passing_state/${var.student_name}/db_address"
  value = aws_db_instance.postgresdb.address
  type  = "String"
}

resource "aws_ssm_parameter" "db_port" {
  name  = "/terraform_workshop/passing_state/${var.student_name}/db_port"
  value = aws_db_instance.postgresdb.port
  type  = "String"
}