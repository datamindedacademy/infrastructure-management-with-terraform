locals {
  notebook_sg_name = "${var.notebook_name}-sg"
  list_of_cidr_blocks = [for ip in var.ip_addresses : "${ip}/32"]
}