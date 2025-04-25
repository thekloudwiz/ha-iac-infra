# Create S3 bucket for Logging
resource "aws_s3_bucket" "logging" {
  bucket        = local.bucket_name
  force_destroy = true

  tags = merge(
    local.common_tags,
    {
      Name    = "${local.bucket_name}"
      Purpose = "S3 bucket for storing logs"
    }
  )
  lifecycle {
    prevent_destroy = false
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.logging.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable Access Logging on ALB logs
resource "aws_s3_bucket_logging" "alb_logs" {
  bucket        = aws_s3_bucket.logging.id
  target_bucket = aws_s3_bucket.logging.id
  target_prefix = "logs/"
}

# Create S3 bucket policy for ALB logs
resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.logging.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_elb_service_account.main.id}:root"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.logging.arn}/*"
      }
    ]
  })
}

# Enable versioning on S3 bucket for ALB logs
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.logging.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.logging.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}