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

