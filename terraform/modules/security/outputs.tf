# ====================================================================
# 1. IAM Outputs
# ====================================================================

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS Task Role"
  value       = aws_iam_role.ecs_task_role.arn
}

# ====================================================================
# 2. Security Group Outputs
# ====================================================================

output "alb_sg_id" {
  description = "ID of the ALB Security Group"
  value       = aws_security_group.alb_sg.id
}

output "ecs_task_sg_id" {
  description = "ID of the ECS Task Security Group"
  value       = aws_security_group.ecs_task_sg.id
}
