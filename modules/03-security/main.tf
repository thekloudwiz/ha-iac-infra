# Create WAF for ALB Against OWASP Top 10
resource "aws_wafv2_web_acl" "alb_waf" {
  name        = local.waf_acl_name
  scope       = "REGIONAL"
  description = "WAF for ALB protecting against OWASP Top 10"
  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = local.waf_metric_name
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "awsCommonRules"
      sampled_requests_enabled   = true
    }
  }

  tags = local.common_tags
}

# Create Security Group for Jump Box
resource "aws_security_group" "jump_sg" {
  name        = local.jump_sg_name
  description = "Security group for Jump Box"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = local.jump_sg_name
  })
}

# Create Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = local.alb_sg_name
  description = "ALB SG: Allow HTTP/HTTPS from anywhere"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.public_destination_cidr]
  }

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.public_destination_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_destination_cidr]
  }

  tags = local.common_tags
}

# Create Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  name        = local.ecs_sg_name
  description = "ECS SG: Allow traffic from ALB"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_destination_cidr]
  }

  tags = local.common_tags
}

# Create Security Group for MySQL
resource "aws_security_group" "mysql_sg" {
  name        = local.mysql_sg_name
  description = "MySQL SG: Allow traffic from ECS"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port       = var.mysql_port
    to_port         = var.mysql_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_destination_cidr]
  }

  tags = local.common_tags
}

# Create Security Group for Postgres
resource "aws_security_group" "postgres_sg" {
  name        = local.postgres_sg_name
  description = "Postgres SG: Allow traffic from ECS"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port       = var.postgres_port
    to_port         = var.postgres_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_destination_cidr]
  }

  tags = local.common_tags
}

# Create Security Group for Redis
resource "aws_security_group" "redis_sg" {
  name        = local.redis_sg_name
  description = "Redis SG: Allow traffic from ECS"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port       = var.redis_port
    to_port         = var.redis_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_destination_cidr]
  }

  tags = local.common_tags
}

# Create Security Group for Kafka
resource "aws_security_group" "kafka_sg" {
  name        = local.kafka_sg_name
  description = "Kafka SG: Allow traffic from ECS"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port       = var.kafka_port
    to_port         = var.kafka_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public_destination_cidr]
  }
}