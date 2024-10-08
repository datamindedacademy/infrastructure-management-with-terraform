# This code is only required if you want to setup your own terraform state S3 bucket and DynamoDB locking table
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

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-training-lock-${random_integer.student_id.result}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "random_integer" "student_id" {
  min = 0
  max = 255
}
