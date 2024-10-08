resource "aws_security_group" "notebook_sg" {
  name        = local.notebook_sg_name
  description = "Allow SSH inbound traffic on user-specified ports and all outbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count            = length(local.list_of_cidr_blocks)
  security_group_id = aws_security_group.notebook_sg.id
  cidr_ipv4         = local.list_of_cidr_blocks[count.index]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.notebook_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
