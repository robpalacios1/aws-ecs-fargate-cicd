# ====================================================================
# 1. Application Load Balancer (ALB) Resources
# ====================================================================

resource "aws_lb" "main_alb" {
    name = "dev-main-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = ["sg-01181e4734b2867e0"]
    subnets = [
        "subnet-03ed6924ae3c8c962",
        "subnet-0c756277348d25821" 
    ]

    enable_deletion_protection = false

    tags = {
        Name = "dev-main-alb"
        Environment = "dev"
    }
}

# ====================================================================
# 2. ALB Target Group
# ====================================================================

resource "aws_lb_target_group" "main_tg" {
    name = "dev-ecs-target-group"
    port = "80"
    protocol = "HTTP"
    vpc_id = "vpc-048c78fa53c9e3a99"
    target_type = "ip"

    #Health Checks Config
    health_check {
        healthy_threshold = 3
        unhealthy_threshold = 2
        timeout = 5
        interval = 30
        path = "/"
        port = "traffic-port"
        protocol = "HTTP"
        matcher = "200"
    } 
    tags = {
        Name = "dev-ecs-target-group"
        environment = "dev"
    }    
}

# ====================================================================
# ALB Listener
# ====================================================================
    
resource "aws_lb_listener" "main_listener" {
    load_balancer_arn = aws_lb.main_alb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.main_tg.arn
    } 
    tags = {
        Name = "dev-main-listener"
        environment = "dev"
    }    
}
