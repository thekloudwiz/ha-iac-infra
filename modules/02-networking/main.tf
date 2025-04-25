# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = merge(local.common_tags, {
    Name = "${local.vpc_name}"
  })
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
    Name = "${local.igw_name}"
  })
}

# Create Web Subnets
resource "aws_subnet" "web" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_bits, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = merge(local.common_tags, {
    Name                     = "${local.web_subnet_name}-${count.index + 1}"
    "kubernetes.io/role/elb" = "1" # For EKS if needed later
    "Type"                   = "Public"
  })
}

# Create App Subnets
resource "aws_subnet" "app" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_bits, count.index + var.az_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = merge(local.common_tags, {
    Name                     = "${local.app_subnet_name}-${count.index + 1}"
    "kubernetes.io/role/elb" = "1" # For EKS if needed later
    "Type"                   = "Private"
  })
}

# Create DB Subnets
resource "aws_subnet" "db" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_bits, count.index + (2 * var.az_count))
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = merge(local.common_tags, {
    Name                     = "${local.db_subnet_name}-${count.index + 1}"
    "kubernetes.io/role/elb" = "1" # For EKS if needed later
    "Type"                   = "Private"
  })
}

# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.public_destination_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.public_rtb_name}"
  })
}

# Aassociate route table with Web subnets
resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = aws_subnet.web[count.index].id
  route_table_id = aws_route_table.public.id

  depends_on = [aws_route_table.public]
}

# Create EIP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = merge(local.common_tags, {
    Name = "${local.nat_eip_name}"
  })
}

# Create NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.web[0].id

  tags = merge(local.common_tags, {
    Name = "${local.nat_gateway_name}"
  })

  depends_on = [aws_eip.nat_eip]
}

# Create Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.public_destination_cidr
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.private_rtb_name}"
  })
}

# Associate route table with App subnets
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.private.id

  depends_on = [aws_route_table.private]
}

# Associate route table with DB subnets
resource "aws_route_table_association" "db" {
  count          = var.az_count
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.private.id

  depends_on = [aws_route_table.private]
}