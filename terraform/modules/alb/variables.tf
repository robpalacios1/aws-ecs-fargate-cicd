# ====================================================================
# 1. ALB Variables
# ====================================================================

variable "main_alb_name" {
  description = "The name of the ALB"
  type        = string
  default = "dev-main-alb"
}

variable "main_alb_security_group_id" {
  description = "The security group ID of the ALB"
  type        = set(string)
}

variable "main_alb_subnets" {
  description = "The list of subnets for the ALB"
  type        = list(string)
}

variable "main_alb_environment" {
  description = "The environment of the ALB"
  type        = string
  default = "dev"
}

# ====================================================================
# 2. Target Group Variables
# ====================================================================

variable "main_tg_name" {
  description = "The name of the target group"
  type        = string
  default = "dev-ecs-target-group"
}

variable "main_tg_port" {
  description = "The port of the target group"
  type        = number
  default = 80
}

variable "vpc_id" {
  description = "The VPC ID where the ALB and Target Group are created"
  type        = string
}

# ====================================================================
# 3. ALB Listener Variables
# ====================================================================

variable "main_listener_port" {
  description = "The port of the listener"
  type        = string
  default = "80"
} 

variable "main_listener_protocol" {
  description = "The protocol of the listener"
  type        = string
  default = "HTTP"
}

variable "main_listener_name" {
  description = "The name of the listener"
  type        = string
  default = "dev-main-listener"
}
