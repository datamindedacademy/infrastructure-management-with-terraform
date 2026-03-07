resource "aws_kms_key" "s3_key" {
  count                   = var.environment == "dev" ? 0 : 1
  description             = "KMS key S3"
  deletion_window_in_days = 10
}