variable "student_id" {
  type = number
  validation {
    condition     = var.student_id >= 0 && var.student_id < 256
    error_message = "The student_id should be between 0 and 256."
  }
}

variable "student_name" {
  type = string
}