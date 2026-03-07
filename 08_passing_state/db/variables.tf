variable "username" {
  description = "Username in the postgres database"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Password to the postgres database"
  type        = string
  sensitive   = true
}

variable "server_port" {
  description = "Port at which our server is listening"
  type        = string
  default     = 8080
}

variable "student_name" {
  default = ""
}