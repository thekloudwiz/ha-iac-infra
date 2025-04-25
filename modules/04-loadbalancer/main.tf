# Create ELB Resources

# Create ALB Target Group
resource "aws_lb_target_group" "alb_target_group" {
  name        = local.target_group_name
  port        = var.health_check_port
  protocol    = var.health_check_protocol
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  target_type = var.target_type

  health_check {
    path                = var.health_check.path
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  lifecycle {
    ignore_changes = [
      name,
      port,
      protocol,
      vpc_id
    ]
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = local.target_group_name
  })
}

# Create the ALB
resource "aws_lb" "alb" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = var.alb_type
  security_groups    = [data.aws_ssm_parameter.alb_sg_id.value]

  subnets = [
    for subnet in data.aws_ssm_parameter.public_subnet_ids :
    subnet.value
  ]

  # Ensure that ALB drops HTTP headers
  drop_invalid_header_fields = true

  access_logs {
    bucket  = data.aws_s3_bucket.alb_logs.id
    prefix  = var.environment
    enabled = true
  }

  enable_deletion_protection = terraform.workspace == "prod" ? true : false

  tags = merge(local.common_tags, {
    Name = local.alb_name
  })
}

# Create ALB Listener for HTTP (handles HTTP traffic)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

# Associate WAF with ALB
resource "aws_wafv2_web_acl_association" "waf_alb_association" {
  resource_arn = aws_ssm_parameter.alb_arn.value
  web_acl_arn  = data.aws_ssm_parameter.waf_acl_arn.value
}