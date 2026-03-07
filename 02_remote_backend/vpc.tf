resource "aws_vpc" "example" {
  cidr_block = "10.${var.student_id}.0.0/24"
}