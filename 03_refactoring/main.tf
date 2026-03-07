terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.46.0"
    }
  }
  backend "s3" {
    bucket  = "better-infrastructure-management-with-terraform"
    key     = "refactoring/terraform.tfstate"
    region  = "eu-west-1"
    profile = "academy"
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "academy"
}

resource "aws_iam_role" "notebook_role" {
  name = "test_role"
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
          Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}
resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                   = "example-notebook-instance-${var.student_name}"
  role_arn               = aws_iam_role.notebook_role.arn
  instance_type          = "ml.t2.medium"
  direct_internet_access = "Disabled"
  subnet_id              = aws_subnet.main.id
  security_groups        = [aws_security_group.allow_tls.id]
}

output "notebook_url" {
  value = aws_sagemaker_notebook_instance.notebook_instance.url
}

variable "student_name" {
  type = string
}
resource "aws_s3_bucket" "notebook_bucket" {
  bucket = "better-infrastructure-management-sagemaker-notebook-bucket-${var.student_name}"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "notebook_bucket_policy" {
  bucket = aws_s3_bucket.notebook_bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*Object"
        Resource = [
          aws_s3_bucket.notebook_bucket.arn,
          "${aws_s3_bucket.notebook_bucket.arn}/*",
        ]
        Condition = {
          NotIpAddress = {
            "aws:SourceIp" = aws_subnet.main.cidr_block
          }
        }
      },
    ]
  })
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

variable "student_id" {
  type = string
}
resource "aws_vpc" "main" {
  cidr_block           = "10.${var.student_id}.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.${var.student_id}.0.0/28"
  map_public_ip_on_launch = false
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.main.id
  service_name    = "com.amazonaws.eu-west-1.s3"
  route_table_ids = [aws_route_table.main.id]
}

resource "aws_vpc_endpoint" "sagemaker_notebook" {
  vpc_id              = aws_vpc.main.id
  service_name        = "aws.sagemaker.eu-west-1.notebook"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.allow_tls.id]
  subnet_ids          = [aws_subnet.main.id]
}


resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}