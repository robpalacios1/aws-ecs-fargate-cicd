# ====================================================================
# 1. Application Load Balancer (ALB) Resources
# ====================================================================

resource "aws_lb" "main_alb" {
  name               = var.main_alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.main_alb_security_group_id
  subnets            = var.main_alb_subnets

  enable_deletion_protection = false

  tags = {
    Name        = var.main_alb_name
    environment = var.main_alb_environment
  }
}

# ====================================================================
# 2. ALB Target Group
# ====================================================================

resource "aws_lb_target_group" "main_tg" {
  name     = var.main_tg_name
  port     = var.main_tg_port
  protocol = "HTTP"

  vpc_id      = var.vpc_id
  target_type = "ip"

  #Health Checks Config
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200"
  }
  tags = {
    Name        = var.main_tg_name
    environment = var.main_alb_environment
  }
}

# ====================================================================
# 3. ALB Listener
# ====================================================================

resource "aws_lb_listener" "main_listener" {
  load_balancer_arn = aws_lb.main_alb.arn
  port              = var.main_listener_port
  protocol          = var.main_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_tg.arn
  }
  tags = {
    Name        = var.main_listener_name
    environment = var.main_alb_environment  
  }
}
