# ====================================================================
# 1. AWS ECR Repository (Private repo for Docker)
# ====================================================================

resource "aws_ecr_repository" "app_repo" {
  name                 = var.app_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.app_repo_name
    environment = var.app_repo_environment
  }
}

# ====================================================================
# 2. AWS ECS Cluster (Managed container orchestration service)
# ====================================================================
resource "aws_ecs_cluster" "main_cluster" {
  name = "dev-main-cluster"
  tags = {
    Name        = var.main_cluster_name
    environment = var.app_repo_environment
  }
}

# ====================================================================
# 3. CloudWatch Log Group (For storing container logs)
# ====================================================================
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = var.ecs_logs_path
  retention_in_days = 7
  tags = {
    Name        = var.ecs_logs_name
    environment = var.app_repo_environment
  }
}

# ====================================================================
# 4. ECS Task Definition (Blueprint for running containers) 
# ====================================================================

resource "aws_ecs_task_definition" "app_task_def" {
  family                   = var.app_task_def_family
  network_mode             = var.app_task_def_network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.app_task_def_cpu
  memory                   = var.app_task_def_memory

  # IAM Roles - placeholder values, will be updated in IAM module outputs
  execution_role_arn = var.task_execution_role_arn
  task_role_arn      = var.task_role_arn

  # Container Definition
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      memory    = tonumber(var.app_task_def_memory)
      cpu       = tonumber(var.app_task_def_cpu)
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = var.protocol
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/dev-app-task"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

# ====================================================================
# 5. ECS Service (Runs and maintains a specified number of task defs)
# ====================================================================

resource "aws_ecs_service" "app_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.app_task_def.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  tags = {
    Name        = var.app_service_name
    environment = var.app_repo_environment
  }
}
    