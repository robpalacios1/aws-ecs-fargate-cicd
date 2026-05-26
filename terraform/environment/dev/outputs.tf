# ====================================================================
# 1. VPC ID 
# ====================================================================

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
}

# ====================================================================
# 2. Public Subnets ID 
# ====================================================================

output "public_subnets_ids" {
  description = "List of ID's Public Subnets"
  value       = module.networking.public_subnets_ids
}

# ====================================================================
# 3. Private Subnets ID 
# ====================================================================

output "private_subnets_ids" {
  description = "List of ID's Private Subnets"
  value       = module.networking.private_subnets_ids
}

# ====================================================================
# 4. Security Module Outputs
# ====================================================================

output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = module.security.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "The ARN of the ECS task role"
  value       = module.security.ecs_task_role_arn
}

output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = module.security.alb_sg_id
}

output "ecs_tasks_security_group_id" {
  description = "The ID of the ECS tasks security group"
  value       = module.security.ecs_task_sg_id
}
