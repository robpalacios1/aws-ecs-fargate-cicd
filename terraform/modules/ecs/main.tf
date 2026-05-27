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