# ====================================================================
# 1. VPC ID 
# ====================================================================

output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.main_vpc.id
}

# ====================================================================
# 2. Public Subnets ID 
# ====================================================================

output "public_subnets_ids" {
  description = "List of ID's Public Subnets"
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}