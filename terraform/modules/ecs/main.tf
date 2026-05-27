# ====================================================================
# 1. AWS ECR Repository (Private repo for Docker)
# ====================================================================

resource "aws_ecr_repository" "app_repo" {
    name = "dev-app-repo"
    image_tag_mutability = "MUTABLE"
    
    image_scanning_configuration {
        scan_on_push = true
    }

    tags = {
        Name = "dev-app-repo"
        environment = "dev"
    }
}

# ====================================================================
# 2. AWS ECS Cluster (Managed container orchestration service)
# ====================================================================
resource "aws_ecs_cluster" "main_cluster" {
    name = "dev-main-cluster"
    tags = {
        Name = "ecs-cluster"
        environment = "dev"
    }
}

# ====================================================================
# 3. CloudWatch Log Group (For storing container logs)
# ====================================================================
resource "aws_cloudwatch_log_group" "ecs_logs" {
    name = "/ecs/dev-app-task"
    retention_in_days = 7
    tags = {
        Name = "ecs-logs-group"
        environment = "dev"
    }
}

# ====================================================================
# 4. ECS Task Definition (Blueprint for running containers) 
# ====================================================================

resource "aws_ecs_task_definition" "app_task_def" {
    family = "dev-app-task-def"
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = "256"
    memory = "512"

    # IAM Roles - placeholder values, will be updated in IAM module outputs
    execution_role_arn = "arn:aws:iam::123456789012:role/dev-ecs-task-execution-role"
    task_role_arn = "arn:aws:iam::123456789012:role/dev-ecs-task-role"
    
    # Container Definition
    container_definitions = jsonencode([
        {
            name = "dev-app-container"
            image = "123456789012.dkr.ecr.us-east-1.amazonaws.com/dev-app-repo:latest" 
            memory = 512
            cpu = 256
            essential = true

            portMappings = [
                {
                    containerPort = 80
                    hostPort = 80
                    protocol = "tcp"
                }
            ]
        
            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    "awslogs-group" = "/ecs/dev-app-task"
                    "awslogs-region" = "us-east-1"
                    "awslogs-stream-prefix" = "ecs"
                }
            }
        }
    ])
}