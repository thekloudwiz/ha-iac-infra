data "aws_iam_policy_document" "s3_logging_policy" {
  statement {
    sid    = "AWSLogDeliveryWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com", "vpc-flow-logs.amazonaws.com", "cloudtrail.amazonaws.com", ]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.logging.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

# Get AWS account info
data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "main" {}