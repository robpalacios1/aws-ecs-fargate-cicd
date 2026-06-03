# ====================================================================
# 1. IAM roles for EKS cluster
# ====================================================================

resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name        = var.eks_cluster_role_name
    environment = var.eks_cluster_role_environment
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = var.eks_cluster_policy_arn
}

# ====================================================================
# 2. IAM roles for EKS Node Group (Workers)
# ====================================================================

resource "aws_iam_role" "eks_node_role" {
  name = var.eks_node_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name        = var.eks_node_role_name
    environment = var.eks_node_role_environment
  }
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = var.eks_worker_node_policy_arn
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = var.eks_cni_policy_arn
}

resource "aws_iam_role_policy_attachment" "ecr_read_only_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = var.eks_ecr_read_only_policy_arn
}


# ====================================================================
# 3. Amazon EKS Cluster
# ====================================================================

resource "aws_eks_cluster" "main_eks" {
  name     = var.main_eks_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.main_eks_subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# ====================================================================
# 4. Amazon EKS Node Group
# ====================================================================

resource "aws_eks_node_group" "main_nodes" {
  cluster_name    = aws_eks_cluster.main_eks.name
  node_group_name = var.main_nodes_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = var.main_nodes_subnets_ids
  scaling_config {
    desired_size = var.main_nodes_desired_size
    max_size     = var.main_nodes_max_size
    min_size     = var.main_nodes_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ecr_read_only_policy,
  ]
  tags = {
    Name        = var.main_node_name
    environment = var.main_nodes_environment
  }
}
