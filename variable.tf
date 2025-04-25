variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "expiry_days" {
  type        = number
  description = "Days after which logs should expire"
}

variable "manager" {
  type        = string
  description = "Name of the S3 bucket for storing logs"
}

variable "owner" {
  type        = string
  description = "Owner of the S3 bucket for storing logs"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for storing logs"
}

variable "az_count" {
  type        = number
  description = "Number of availability zones to use"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_bits" {
  description = "Subnet bits for the VPC"
  type        = number

}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "web_subnet_name" {
  description = "Name of the Web Subnet"
  type        = string
}

variable "app_subnet_name" {
  description = "Name of the Application Subnet"
  type        = string
}

variable "db_subnet_name" {
  description = "Name of the Database Subnet"
  type        = string
}

variable "public_rtb_name" {
  description = "Name of the Public Route Table"
  type        = string
}

variable "private_rtb_name" {
  description = "Name of the Private Route Table"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "nat_eip_name" {
  description = "Name of the Elastic IP for the NAT Gateway"
  type        = string
}

variable "public_destination_cidr" {
  description = "Destination CIDR block for public route table"
  type        = string
}

variable "ssh_port" {
  type        = number
  description = "SSH port for the jump box security group"
}

variable "my_ip" {
  type        = string
  description = "Your IP address for the jump box security group"
}

variable "http_port" {
  type        = number
  description = "HTTP port for the ALB security group"
}

variable "mysql_port" {
  type        = number
  description = "MySQL port for the MySQL security group"

}

variable "postgres_port" {
  type        = number
  description = "Postgres port for the Postgres security group"
}

variable "redis_port" {
  type        = number
  description = "Redis port for the Redis security group"
}

variable "kafka_port" {
  type        = number
  description = "Kafka port for the Kafka security group"
}

variable "waf_acl_name" {
  type        = string
  description = "Name of the WAF ACL"
}

variable "waf_metric_name" {
  type        = string
  description = "Name of the WAF metric"

}

variable "jump_sg_name" {
  type        = string
  description = "Name of the Jump Box security group"
}

variable "alb_sg_name" {
  type        = string
  description = "Name of the ALB security group"
}

variable "ecs_sg_name" {
  type        = string
  description = "Name of the ECS security group"
}

variable "mysql_sg_name" {
  type        = string
  description = "Name of the RDS security group"
}

variable "postgres_sg_name" {
  type        = string
  description = "Name of the Postgres security group"
}

variable "redis_sg_name" {
  type        = string
  description = "Name of the Redis security group"
}

variable "kafka_sg_name" {
  type        = string
  description = "Name of the Kafka security group"
}

# Health Check Port
variable "health_check_port" {
  description = "Port for health check"
  type        = number
}

# Health Check Protocol
variable "health_check_protocol" {
  description = "Protocol for health check"
  type        = string
}

# Redirect Port
variable "https_port" {
  description = "Port for redirecting HTTP to HTTPS"
  type        = number
}

# ALB Type
variable "alb_type" {
  description = "Type of the ALB"
  type        = string
}

# Target Type
variable "target_type" {
  description = "Target type for the ALB"
  type        = string
}

# Health Check Variables
variable "health_check" {
  type = object({
    path                = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })
}

# ALB Name
variable "alb_name" {
  type        = string
  description = "Name of the ALB"
}

# ALB Target Group Name
variable "target_group_name" {
  type        = string
  description = "Name of the ALB target group"
}