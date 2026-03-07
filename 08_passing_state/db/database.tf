resource "aws_db_instance" "postgresdb" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "16.4"
  instance_class       = "db.t3.micro"
  db_name              = "postgres-db-${var.student_name}"
  username             = var.username
  password             = var.password
  parameter_group_name = aws_db_parameter_group.education.name
  skip_final_snapshot  = true
}

resource "aws_db_parameter_group" "education" {
  name   = "education"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}