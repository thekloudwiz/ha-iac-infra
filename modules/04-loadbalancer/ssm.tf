# Store ELB Credentials in SSM Parameter Store
# Add SSM parameter for target group ARN
resource "aws_ssm_parameter" "alb_target_group_arn" {
  name  = "/${local.name_prefix}/alb_target_group_arn"
  type  = "String"
  value = aws_lb_target_group.alb_target_group.arn

  tags = local.common_tags
}

# Store ALB ARN in SSM Parameter Store
resource "aws_ssm_parameter" "alb_arn" {
  name  = "/${local.name_prefix}/alb_arn"
  type  = "String"
  value = aws_lb.alb.arn

  tags = local.common_tags
}

# Store ALB Zone ID in SSM Parameter Store
resource "aws_ssm_parameter" "alb_zone_id" {
  name  = "/${local.name_prefix}/alb_zone_id"
  type  = "String"
  value = aws_lb.alb.zone_id
  tags  = local.common_tags
}

# Store ALB DNS Name in SSM Parameter Store
resource "aws_ssm_parameter" "alb_dns_name" {
  name  = "/${local.name_prefix}/alb_dns_name"
  type  = "String"
  value = aws_lb.alb.dns_name
  tags  = local.common_tags
}