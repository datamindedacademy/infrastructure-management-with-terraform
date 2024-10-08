locals {
  
}


module "secure_notebook" {
  source        = "./secure_notebook"
  ip_addresses  = ["196.3.3.3"]
  notebook_name = "secure-notebook"
  instance_type = "ml.t2.medium"
}




