# TODO: create IAM role which will be assumed by Notebook instance to access S3 bucket
resource "aws_iam_role" "notebook_role" {
  name = "sagemaker_notebook_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = []

  inline_policy {
    name = "S3_access"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid = "ListBuckets"
          Action = [
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
          ]
          Effect = "Allow"
          Resource = [
          "arn:aws:s3:::*"]
        },
        {
          Action = [
            "s3:*Object",
          ]
          Effect = "Allow"
          Resource = [
            aws_s3_bucket.notebook_bucket.arn,
            "${aws_s3_bucket.notebook_bucket.arn}/*",
          ]
        },
      ]
    })
  }
}
