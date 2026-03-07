variable "environment" {
  type    = string
  default = "dev"

  validation {
    condition     = var.environment == "dev" || var.environment == "prod"
    error_message = "The environment should be either dev or prod!"
  }
}
variable "notebook_name" {
  type = string
}

variable "my_ip" {
  type = string
}