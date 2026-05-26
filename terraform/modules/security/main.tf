# ====================================================================
# 1. IAM roles for ECS
# ====================================================================

# Role for ECS Task Execution (allows ECS to pull images, push logs)
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "dev-ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ecs-tasks.amazonws.com"
            }
        }
    ]
  })

  tags = {
    Name = "ecs_task_execution_role"
    environment = "dev"
  }
}

# Policy Attachment: Attach the Task Execution Role Policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
  role = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Role for ECS Task (allows ECS Tasks to make API calls on your behalf)
resource "aws_iam_role" "ecs_task_role" {
  name = "dev-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ecs-task.amazonaws.com"
            }
        }
    ]
  })

  tags = {
    Name = "ecs-task-role"
    environment = "dev"
  }
}

# ====================================================================
# 2. Security Groups
# ====================================================================

# Security Group for ALB (allows public access)
resource "aws_security_group" "alb_sg" {
  description = "Controls access to the ALB"
  name = "dev-alb-security-group"
  vpc_id = var.vpc_id

  # Ingress: Allow HTTP and HTTPS traffic from anywhere (World)
  ingress {
    description = "Allow HTTP traffic from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress: Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "dev-alb-security-group"
    environment = "dev"
  }
}

resource "aws_security_group" "ecs_task_sg" {
  description = "Controls access to the ECS Fargate Task"
  name = "dev-ecs-task-security-group"
  vpc_id = var.vpc_id

  # Ingress: Allow HTTP traffic from the ALB Security Group
  ingress {
    description = "Allow HTTP traffic from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Egress: Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "dev-ecs-task-security-group"
    environment = "dev"
  }
}