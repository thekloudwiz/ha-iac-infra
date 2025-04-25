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
  default     = 365
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