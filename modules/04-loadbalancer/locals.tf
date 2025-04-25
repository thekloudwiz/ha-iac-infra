# Local Variables for Naming conventions
locals {
  name_prefix = "${var.environment}-${var.project_name}-${var.region}"

  # Common tags for all resources
  common_tags = {
    Environment = terraform.workspace
    Managed_by  = var.manager
    Owner       = var.owner
    Project     = "${var.project_name}"
  }
}

# Local variables for resource names
locals {
  alb_name             = "${local.name_prefix}-${var.alb_name}"
  target_group_name    = "${local.name_prefix}-${var.target_group_name}"
  alb_logs_bucket_name = "${local.name_prefix}-${var.bucket_name}"
}