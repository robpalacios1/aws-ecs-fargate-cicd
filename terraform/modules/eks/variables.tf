# ====================================================================
# 1. Variables for EKS roles    
# ====================================================================

variable "eks_cluster_role_name" {
  description = "Name of EKS cluster role"
  type        = string
  default     = "dev-eks-cluster-role"
}

variable "eks_cluster_role_environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "eks_cluster_policy_arn" {
  description = "value"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# ====================================================================
# 2. Variables for EKS Node Group
# ====================================================================

variable "eks_node_role_name" {
  description = "Name of EKS node group"
  type        = string
  default     = "dev-eks-node-group"
}

variable "eks_node_role_environment" {
  description = "Environment name for EKS node group"
  default     = "dev"
}

variable "eks_worker_node_policy_arn" {
  description = "EKS worker node policy ARN"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "eks_cni_policy_arn" {
  description = "EKS CNI policy ARN"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "eks_ecr_read_only_policy_arn" {
  description = "EKS ECR read only policy ARN"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# ====================================================================
# 3. Variables for EKS Cluster
# ====================================================================

variable "main_eks_name" {
  description = "Name of EKS cluster"
  type        = string
  default     = "dev-eks"
}

variable "main_eks_subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

# ====================================================================
# 4. Variables for EKS Node Group
# ====================================================================

variable "main_nodes_group_name" {
  description = "Name of EKS node group"
  type        = string
  default     = "dev-eks-nodes"
}

variable "main_nodes_subnets_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "main_nodes_desired_size" {
  description = "Desired size of EKS node group"
  type        = number
  default     = 2
}

variable "main_nodes_max_size" {
  description = "Maximum size of EKS node group"
  type        = number
  default     = 3
}

variable "main_nodes_min_size" {
  description = "Minimum size of EKS node group"
  type        = number
  default     = 1
}

variable "main_node_name" {
  description = "Name of EKS nodes"
  type        = string
  default     = "dev-eks-nodes"
}

variable "main_nodes_environment" {
  description = "Environment name for EKS node group"
  type        = string
  default     = "dev"
}