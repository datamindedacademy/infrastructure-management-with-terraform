resource "aws_ssm_parameter" "first_cicd_resource" {
  name  = "/cicd-test"
  type  = "String"
  value = "Hello Terraform! This resource has been created by CICD"
}