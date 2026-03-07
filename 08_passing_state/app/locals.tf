locals {
  #  db_address = data.terraform_remote_state.db_state.outputs.db_address
  #  db_port = data.terraform_remote_state.db_state.outputs.db_port

  db_address = data.aws_ssm_parameter.db_address.value
  db_port    = data.aws_ssm_parameter.db_port.value
}