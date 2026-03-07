locals {
  ip_addresses = ["81.164.187.254", "81.164.187.255"]
  name         = "notebook-Jan"
}


module "secure_notebook" {
  source        = "./secure_notebook"
  ip_addresses  = local.ip_addresses
  notebook_name = local.name
  instance_type = "ml.t2.medium"
}




