# Provision Storage Module for Loging
module "storage" {
  source       = "./modules/01-storage"
  bucket_name  = var.bucket_name
  environment  = var.environment
  project_name = var.project_name
  manager      = var.manager
  owner        = var.owner
  region       = var.region
  expiry_days  = var.expiry_days
}

# Provision Network Module
module "network" {
  source                  = "./modules/02-networking/"
  vpc_name                = var.vpc_name
  environment             = var.environment
  project_name            = var.project_name
  region                  = var.region
  manager                 = var.manager
  owner                   = var.owner
  az_count                = var.az_count
  vpc_cidr                = var.vpc_cidr
  subnet_bits             = var.subnet_bits
  igw_name                = var.igw_name
  web_subnet_name         = var.web_subnet_name
  app_subnet_name         = var.app_subnet_name
  db_subnet_name          = var.db_subnet_name
  public_rtb_name         = var.public_rtb_name
  private_rtb_name        = var.private_rtb_name
  nat_gateway_name        = var.nat_gateway_name
  nat_eip_name            = var.nat_eip_name
  public_destination_cidr = var.public_destination_cidr

  depends_on = [ module.storage ]
}

# Provision Security
module "security" {
  source                  = "./modules/03-security"
  environment             = var.environment
  project_name            = var.project_name
  region                  = var.region
  manager                 = var.manager
  owner                   = var.owner
  vpc_name                = var.vpc_name
  waf_acl_name            = var.waf_acl_name
  waf_metric_name         = var.waf_metric_name
  jump_sg_name            = var.jump_sg_name
  alb_sg_name             = var.alb_sg_name
  ecs_sg_name             = var.ecs_sg_name
  mysql_sg_name           = var.mysql_sg_name
  postgres_sg_name        = var.postgres_sg_name
  redis_sg_name           = var.redis_sg_name
  kafka_sg_name           = var.kafka_sg_name
  public_destination_cidr = var.public_destination_cidr
  ssh_port                = var.ssh_port
  my_ip                   = var.my_ip
  http_port               = var.http_port
  mysql_port              = var.mysql_port
  postgres_port           = var.postgres_port
  redis_port              = var.redis_port
  kafka_port              = var.kafka_port

  depends_on = [ module.network ]
}

# # Provision Load Balancer Module
# Create Load Balancer Module
module "load_balancer" {
  source                = "./modules/04-loadbalancer"
  az_count = var.az_count
  alb_type              = var.alb_type
  target_type           = var.target_type
  alb_name              = var.alb_name
  bucket_name           = var.bucket_name
  target_group_name     = var.target_group_name
  health_check          = var.health_check
  health_check_port     = var.health_check_port
  health_check_protocol = var.health_check_protocol
  http_port             = var.http_port
  https_port            = var.https_port
  environment           = var.environment
  project_name          = var.project_name
  manager               = var.manager
  owner                 = var.owner
  region                = var.region

  depends_on = [module.network, module.security, module.storage]
}

# # Provision Compute Module
# module "compute" {
#     source = "./modules/04-compute"
# }

# # Provision Database Module
# module "database" {
#     source = "./modules/05-database"
# }