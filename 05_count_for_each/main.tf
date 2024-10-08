locals {
  users          = ["Alice", "Bob", "Chris", "Diana", "Erin"]
  instance_types = ["ml.t2.medium", "ml.m4.xlarge", "ml.t2.medium", "ml.t3.medium", "ml.t2.medium"]
  ip_users       = ["1.1.1.1", "1.1.1.2", "1.1.1.3", "1.1.1.4", "1.1.1.5"]

  user_map = {
    "Alice" = {
      instance_type = "ml.t2.medium"
      ip_address    = "1.1.1.1"
    }
    "Bob" = {
      instance_type = "ml.m4.xlarge"
      ip_address    = "1.1.1.2"
    }
    "Chris" = {
      instance_type = "ml.t2.medium"
      ip_address    = "1.1.1.3"
    }
    "Diana" = {
      instance_type = "ml.t3.medium"
      ip_address    = "1.1.1.4"
    }
    "Erin" = {
      instance_type = "ml.t2.medium"
      ip_address    = "1.1.1.5"
    }
  }

}




### Using Count
module "secure_notebooks" {
  count         = length(local.users)
  source        = "./secure_notebook"
  ip_address    = local.ip_users[count.index]
  notebook_name = local.users[count.index]
  instance_type = local.instance_types[count.index]
}

### Using For Each
# module "secure_notebooks" {
#   for_each      = local.user_map
#   source        = "./secure_notebook"
#   ip_address    = each.value.ip_address
#   notebook_name = each.key
#   instance_type = each.value.instance_type
# }
