# ====================================================================
# Output EKS Cluster
# ====================================================================
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.main_eks.endpoint
}

output "cluster_name" {
  description = "Name of EKS cluster"
  value       = aws_eks_cluster.main_eks.name
}