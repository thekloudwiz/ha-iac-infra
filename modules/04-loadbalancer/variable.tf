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

variable "manager" {
  type        = string
  description = "Name of the S3 bucket for storing logs"
}

variable "owner" {
  type        = string
  description = "Owner of the S3 bucket for storing logs"
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

# ALB HTTPS Port
variable "https_port" {
  description = "HTTPS port for ALB"
  type        = number
}

# HTTP Port
variable "http_port" {
  type        = number
  description = "HTTP port for the ALB security group"
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

# ALB Logging Bucket Name
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for ALB logs"
}

variable "az_count" {
  type        = number
  description = "Number of availability zones to use"
}