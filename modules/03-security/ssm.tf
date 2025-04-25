# Store WAF ACL ARN in SSM Parameter Store
resource "aws_ssm_parameter" "waf_acl_arn" {
  name  = "/${local.name_prefix}/waf_acl_arn"
  type  = "SecureString"
  value = aws_wafv2_web_acl.alb_waf.arn
}

# Store Jump Server Security Group ID in SSM Parameter Store
resource "aws_ssm_parameter" "jump_sg_id" {
  name  = "/${local.name_prefix}/jump_sg_id"
  type  = "SecureString"
  value = aws_security_group.jump_sg.id
}

# Store Web Server Security Group ID in SSM Parameter Store
resource "aws_ssm_parameter" "alb_sg_id" {
  name  = "/${local.name_prefix}/alb_sg_id"
  type  = "SecureString"
  value = aws_security_group.alb_sg.id
}

# Store ECS Security Group ID in SSM Parameter Store
resource "aws_ssm_parameter" "ecs_sg_id" {
  name  = "/${local.name_prefix}/ecs_sg_id"
  type  = "SecureString"
  value = aws_security_group.ecs_sg.id
}

# Store MySQL Security Group ID in SSM Parameter Store
resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${local.name_prefix}/mysql_sg_id"
  type  = "SecureString"
  value = aws_security_group.mysql_sg.id
}

# Store Postgres Security Group ID in SSM Parameter Store
resource "aws_ssm_parameter" "postgres_sg_id" {
  name  = "/${local.name_prefix}/postgres_sg_id"
  type  = "SecureString"
  value = aws_security_group.postgres_sg.id
}

# Store Redis Security Group ID in SSM Parameter Store
resource "aws_ssm_parameter" "redis_sg_id" {
  name  = "/${local.name_prefix}/redis_sg_id"
  type  = "SecureString"
  value = aws_security_group.redis_sg.id
}

# Store Kafka Security Group ID in SSM Parameter Store
resource "aws_ssm_parameter" "kafka_sg_id" {
  name  = "/${local.name_prefix}/kafka_sg_id"
  type  = "SecureString"
  value = aws_security_group.kafka_sg.id
}
