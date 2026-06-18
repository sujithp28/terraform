# Example: Production-grade EKS cluster deployment

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
      CreatedAt   = timestamp()
    }
  }
}

module "eks" {
  source = "../../modules/eks"

  cluster_name         = "${var.project_name}-${var.environment}"
  kubernetes_version   = var.kubernetes_version
  vpc_id               = var.vpc_id
  private_subnet_ids   = var.private_subnet_ids

  # System node group for Kubernetes system components
  system_desired_size   = var.system_desired_size
  system_min_size       = var.system_min_size
  system_max_size       = var.system_max_size
  system_instance_types = var.system_instance_types
  system_disk_size      = 100

  # Application node group for application workloads
  enable_application_node_group = var.enable_application_node_group
  application_desired_size      = var.application_desired_size
  application_min_size          = var.application_min_size
  application_max_size          = var.application_max_size
  application_instance_types    = var.application_instance_types
  application_disk_size         = 100

  # GPU node group (optional)
  enable_gpu_node_group = var.enable_gpu_node_group
  gpu_desired_size      = var.gpu_desired_size
  gpu_min_size          = var.gpu_min_size
  gpu_max_size          = var.gpu_max_size
  gpu_instance_types    = var.gpu_instance_types
  gpu_disk_size         = 200

  # API endpoint configuration
  endpoint_private_access           = var.endpoint_private_access
  endpoint_public_access            = var.endpoint_public_access
  public_access_cidrs               = var.public_access_cidrs
  cluster_endpoint_private_access_cidrs = var.cluster_endpoint_private_access_cidrs

  # Logging configuration
  cluster_enabled_log_types      = var.cluster_enabled_log_types
  cluster_log_retention_in_days  = var.cluster_log_retention_in_days

  # Add-ons
  enable_efs_csi_driver = var.enable_efs_csi_driver

  # Encryption
  kms_key_deletion_window_in_days = 7

  # IAM
  iam_role_permissions_boundary = var.iam_role_permissions_boundary

  tags = merge(
    var.tags,
    {
      ClusterName = "${var.project_name}-${var.environment}"
    }
  )
}

output "eks_cluster_id" {
  value       = module.eks.cluster_id
  description = "EKS cluster ID"
}

output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS cluster endpoint"
}

output "eks_cluster_security_group_id" {
  value       = module.eks.cluster_security_group_id
  description = "EKS cluster security group ID"
}

output "eks_node_security_group_id" {
  value       = module.eks.node_security_group_id
  description = "EKS node security group ID"
}

output "eks_cluster_oidc_issuer_url" {
  value       = module.eks.cluster_oidc_issuer_url
  description = "OIDC issuer URL for IRSA"
}

output "eks_oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "OIDC provider ARN"
}
