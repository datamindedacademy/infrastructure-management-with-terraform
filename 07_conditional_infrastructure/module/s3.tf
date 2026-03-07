resource "aws_s3_bucket" "environment_bucket" {
  bucket = "conditional-bucket-${var.environment}"

  tags = {
    Name        = "my-bucket-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "environment_bucket" {
  count  = var.environment == "dev" ? 0 : 1
  bucket = aws_s3_bucket.environment_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "environment_bucket" {
  bucket = aws_s3_bucket.environment_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.environment == "dev" ? "" : aws_kms_key.s3_key[0].id
      sse_algorithm     = var.environment == "dev" ? "AES256" : "aws:kms"
    }
  }
}

resource "aws_s3_bucket_policy" "environment_bucket_policy" {
  bucket = aws_s3_bucket.environment_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid    = "VPCAllow"
        Effect = "Deny"
        Principal = {
          "AWS" : "*"
        }
        Action = [
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.environment_bucket.arn,
          "${aws_s3_bucket.environment_bucket.arn}/*"
        ]
        Condition = var.environment == "dev" ? local.condition_dev : local.condition_prod
      },
    ]
  })
}

locals {
  condition_dev = {
    NotIpAddress = {
      "aws:SourceIp" = var.my_ip
    },
  }
  condition_prod = {
    StringNotEquals = {
      "aws:SourceVpc" = data.aws_ssm_parameter.vpc_id.value
    },
  }
}
