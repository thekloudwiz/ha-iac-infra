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

variable "az_count" {
  type        = number
  description = "Number of availability zones to use"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_bits" {
  description = "Subnet bits for the VPC"
  type        = number

}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
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