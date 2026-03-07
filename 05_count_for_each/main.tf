locals {
  users = {
    "Alice" : {
      "ip" : "1.1.1.1",
      "type" : "ml.t2.medium",
    },
    "Bob" : {
      "ip" : "1.1.1.2",
      "type" : "ml.p2.xlarge",
    },
    "Chris" : {
      "ip" : "1.1.1.3",
      "type" : "ml.t2.medium",
    },
    "Diana" : {
      "ip" : "1.1.1.4",
      "type" : "ml.t3.medium",
    },
    "Erin" : {
      "ip" : "1.1.1.5.",
      "type" : "ml.t2.medium",
    },
  }
}

module "secure_notebooks" {
  for_each      = local.users
  source        = "./secure_notebook"
  ip_address    = each.value.ip
  notebook_name = join("", ["notebook-", each.key])
  instance_type = each.value.type
}
