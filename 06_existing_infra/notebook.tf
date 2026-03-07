resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                   = "sagemaker-notebook-instance-${var.student_name}"
  role_arn               = aws_iam_role.notebook_role.arn
  instance_type          = "ml.t2.medium"
  direct_internet_access = "Disabled"
  subnet_id              = aws_subnet.main.id
  security_groups        = [aws_security_group.allow_tls.id]
}
