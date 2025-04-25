# Retrieve VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/${local.name_prefix}/vpc_id"
}