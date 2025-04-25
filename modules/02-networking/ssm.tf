# Store VPC ID in SSM Parameter Store
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${local.name_prefix}/vpc_id"
  type  = "SecureString"
  value = aws_vpc.vpc.id
}

# Store Internet Gateway ID in SSM Parameter Store
resource "aws_ssm_parameter" "igw_id" {
  name  = "/${local.name_prefix}/igw_id"
  type  = "SecureString"
  value = aws_internet_gateway.igw.id
}

# Store Web Subnet IDs in SSM Parameter Store
resource "aws_ssm_parameter" "public_subnet_ids" {
  count = var.az_count
  name  = "/${local.name_prefix}/public_subnet_id-${count.index + 1}"
  type  = "SecureString"
  value = aws_subnet.web[count.index].id
}

# Store App Subnet IDs in SSM Parameter Store
resource "aws_ssm_parameter" "app_subnet_ids" {
  count = var.az_count
  name  = "/${local.name_prefix}/app_subnet_id-${count.index + 1}"
  type  = "SecureString"
  value = aws_subnet.app[count.index].id
}

# Store DB Subnet IDs in SSM Parameter Store
resource "aws_ssm_parameter" "db_subnet_ids" {
  count = var.az_count
  name  = "/${local.name_prefix}/db_subnet_id-${count.index + 1}"
  type  = "SecureString"
  value = aws_subnet.db[count.index].id
}

# Store Public Route Table ID in SSM Parameter Store
resource "aws_ssm_parameter" "public_route_table_id" {
  name  = "/${local.name_prefix}/public_rtb_id"
  type  = "SecureString"
  value = aws_route_table.public.id
}

# Store Private Route Table ID in SSM Parameter Store
resource "aws_ssm_parameter" "app_private_route_table_ids" {
  name  = "/${local.name_prefix}/private_rtb_id"
  type  = "SecureString"
  value = aws_route_table.private.id
}

# Store NAT ID in SSM Parameter Store
resource "aws_ssm_parameter" "nat_ip" {
  name  = "/${local.name_prefix}/nat_eip"
  type  = "SecureString"
  value = aws_nat_gateway.ngw.id
}