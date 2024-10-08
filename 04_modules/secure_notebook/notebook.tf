resource "aws_sagemaker_notebook_instance" "modular_notebook" {
    name          = var.notebook_name
    role_arn      = data.aws_ssm_parameter.iam_role.value
    instance_type = var.instance_type
    subnet_id     = data.aws_ssm_parameter.subnet_id.value
    security_groups = [aws_security_group.notebook_sg.id]
}
