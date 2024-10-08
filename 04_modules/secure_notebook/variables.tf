
variable "notebook_name" {
    type = string
    description = "The name of the notebook"
}

variable "ip_addresses" {
    type = list(string)
    description = "The IP address that should be able to SSH into the notebook"
}

variable "instance_type" {
    type = string
    description = "The instance type of the notebook"
}
