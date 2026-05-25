# ====================================================================
# 1. Variables VPC
# ====================================================================

variable "main_vpc_cidr_block" {
  description = "The CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "main_vpc_name" {
  description = "VPC Name"
  type = string
  default = "development"
}

variable "main_vpc_environment" {
  description = "VPC Environment"
  type = string
  default = "dev"
}