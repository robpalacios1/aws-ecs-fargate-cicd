# ====================================================================
# 1. ECR Variables
# ====================================================================

variable "app_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "dev-app-repo"
}

variable "app_repo_environment" {
  description = "Environment of the ECR repository"
  type        = string
  default     = "dev"
}


# ====================================================================
# 2. ECS Variables
# ====================================================================

variable "main_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "dev-main-cluster"
}

# ====================================================================
# 3. CloudWatch Variables
# ====================================================================

variable "ecs_logs_path" {
  description = "Path of the CloudWatch log group"
  type        = string
  default     = "/ecs/dev-app-task"
}

variable "ecs_logs_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = "dev-ecs-logs"
}

# ====================================================================
# 4. ECS Task Definition Variables
# ====================================================================

variable "app_task_def_family" {
  description = "Family name for the Task Definition"
  type        = string
  default     = "dev-app-task"
}

variable "app_task_def_network_mode" {
  description = "Network mode for the Task Definition"
  type        = string
  default     = "awsvpc"
}

variable "app_task_def_requires_compatibilities" {
  description = ""
  type        = string
  default     = "FARGATE"
}

variable "app_task_def_cpu" {
  description = "CPU of the Task Definition"
  type        = string
  default     = "256"
}

variable "app_task_def_memory" {
  description = "Memory of the Task Definition"
  type        = string
  default     = "512"
}

variable "task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "dev-app-container"
}

variable "container_image" {
  description = "Image of the container"
  type        = string
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 80
}

variable "host_port" {
  description = "Host port of the container"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Protocol of the container"
  type        = string
  default     = "tcp"
}

# ====================================================================
# 5. ECS Service Variables
# ====================================================================
variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "dev-app-service"
}

variable "desired_count" {
  description = "Number of desired tasks"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "List of subnets for the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups for the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group for the load balancer"
  type        = string
}

variable "app_service_name" {
  description = "Name of the ECS service"
  type        = string
}
