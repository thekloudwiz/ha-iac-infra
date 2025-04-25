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

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"

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

variable "public_destination_cidr" {
  type        = string
  description = "CIDR block for the public destination"
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