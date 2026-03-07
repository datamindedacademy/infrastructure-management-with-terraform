locals {
  my_ip_cidr = join("", [var.ip_address, "/32"])
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/terraform_training/vpc_id"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    description = "TLS from my IP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}