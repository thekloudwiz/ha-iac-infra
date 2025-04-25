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

  vpc_name         = "${local.name_prefix}-${var.vpc_name}"
  igw_name         = "${local.name_prefix}-${var.igw_name}"
  web_subnet_name  = "${local.name_prefix}-${var.web_subnet_name}"
  app_subnet_name  = "${local.name_prefix}-${var.app_subnet_name}"
  db_subnet_name   = "${local.name_prefix}-${var.db_subnet_name}"
  public_rtb_name  = "${local.name_prefix}-${var.public_rtb_name}"
  private_rtb_name = "${local.name_prefix}-${var.private_rtb_name}"
  nat_gateway_name = "${local.name_prefix}-${var.nat_gateway_name}"
  nat_eip_name     = "${local.name_prefix}-${var.nat_eip_name}"
}