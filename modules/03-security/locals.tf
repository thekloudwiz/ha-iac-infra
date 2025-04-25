# Local variables Naming convention for resources
# and common tags for all resources
locals {
  name_prefix = "${var.environment}-${var.project_name}-${var.region}"
}

# Common Tags for all resources
locals {
  common_tags = {
    Environment = var.environment
    Managed_by  = var.manager
    Owner       = var.owner
    Project     = "${var.project_name}"
  }
}

# Local variables for resource names
locals {
  waf_acl_name     = "${local.name_prefix}-${var.waf_acl_name}"
  waf_metric_name  = "${local.name_prefix}-${var.waf_metric_name}"
  jump_sg_name     = "${local.name_prefix}-${var.jump_sg_name}"
  alb_sg_name      = "${local.name_prefix}-${var.alb_sg_name}"
  ecs_sg_name      = "${local.name_prefix}-${var.ecs_sg_name}"
  mysql_sg_name    = "${local.name_prefix}-${var.mysql_sg_name}"
  postgres_sg_name = "${local.name_prefix}-${var.postgres_sg_name}"
  redis_sg_name    = "${local.name_prefix}-${var.redis_sg_name}"
  kafka_sg_name    = "${local.name_prefix}-${var.kafka_sg_name}"
  vpc_name         = "${local.name_prefix}-${var.vpc_name}"
}