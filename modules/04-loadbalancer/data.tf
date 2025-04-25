# Fetch Networking Credentials from SSM Parameter Store
# To be referenced in the ALB Module

# Fetch Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Fetch VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/${local.name_prefix}/vpc_id"
}

# Fetch Subnet IDS from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  count = var.az_count
  name  = "/${local.name_prefix}/public_subnet_id-${count.index + 1}"
}


# Fetch Security ALB Security Group IDs from SSM Parameter Store
data "aws_ssm_parameter" "alb_sg_id" {
  name = "/${local.name_prefix}/alb_sg_id"
}

# Fetch Log Bucket From SSM Parameter Store
data "aws_s3_bucket" "alb_logs" {
  bucket = "${local.name_prefix}-logs-bucket"
}

# Retrieve WAF ACL ARN from SSM Parameter Store
data "aws_ssm_parameter" "waf_acl_arn" {
  name = "/${local.name_prefix}/waf_acl_arn"
}