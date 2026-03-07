variable "instance_type" {
  type        = string
  description = "type of the instance"
  default     = "ml.t2.medium"
}

variable "notebook_name" {
  type        = string
  description = "name of the notebook instance"
}

variable "ip_addresses" {
  type        = list(string)
  description = "ip addresses to which ingress traffic is limited"
}