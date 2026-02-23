# This code is only required if you want to setup your own terraform state S3 bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = "better-infrastructure-management-with-terraform-${random_integer.student_id.result}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_config" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_config" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_integer" "student_id" {
  min = 0
  max = 255
}
