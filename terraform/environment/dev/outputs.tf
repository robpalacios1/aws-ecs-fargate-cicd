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
