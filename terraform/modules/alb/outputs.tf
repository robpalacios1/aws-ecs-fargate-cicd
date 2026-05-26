# ====================================================================
# 1. ALB Outputs
# ====================================================================

output "target_group_arn" {
  description = "The ARN of the ALB Target Group"
  value       = aws_lb_target_group.main_tg.arn
}

output "alb_dns_name" {
  description = "The DNS Name of the ALB"
  value = aws_lb.main_alb.dns_name
}