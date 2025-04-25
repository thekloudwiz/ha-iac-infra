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
  bucket_name = "${local.name_prefix}-${var.bucket_name}"
}