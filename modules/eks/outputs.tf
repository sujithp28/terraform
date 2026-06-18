output "cluster_id" {
  description = "The ID/name of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = aws_eks_cluster.main.arn
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_version" {
  description = "The Kubernetes server version for the cluster"
  value       = aws_eks_cluster.main.version
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = aws_security_group.cluster.id
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster"
  value       = aws_iam_role.cluster.arn
}

output "node_security_group_id" {
  description = "Security group ID attached to EKS nodes"
  value       = aws_security_group.node.id
}

output "node_iam_role_arn" {
  description = "IAM role ARN for EKS nodes"
  value       = aws_iam_role.node.arn
}

output "system_node_group_id" {
  description = "EKS system node group id"
  value       = aws_eks_node_group.system.id
}

output "system_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS system node group"
  value       = aws_eks_node_group.system.arn
}

output "application_node_group_id" {
  description = "EKS application node group id"
  value       = try(aws_eks_node_group.application[0].id, null)
}

output "application_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS application node group"
  value       = try(aws_eks_node_group.application[0].arn, null)
}

output "gpu_node_group_id" {
  description = "EKS GPU node group id"
  value       = try(aws_eks_node_group.gpu[0].id, null)
}

output "gpu_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS GPU node group"
  value       = try(aws_eks_node_group.gpu[0].arn, null)
}

output "cluster_ca_certificate" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
  sensitive   = true
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = try(aws_eks_cluster.main.identity[0].oidc[0].issuer, null)
}

output "oidc_provider_arn" {
  description = "ARN of the OIDC Provider for EKS"
  value       = try(aws_iam_openid_connect_provider.eks.arn, null)
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group for cluster logs"
  value       = aws_cloudwatch_log_group.cluster.name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group for cluster logs"
  value       = aws_cloudwatch_log_group.cluster.arn
}

output "kms_key_id" {
  description = "KMS key ID for EKS cluster encryption"
  value       = aws_kms_key.cluster.id
}

output "kms_key_arn" {
  description = "KMS key ARN for EKS cluster encryption"
  value       = aws_kms_key.cluster.arn
}

output "vpc_cni_role_arn" {
  description = "IAM role ARN for VPC CNI"
  value       = aws_iam_role.vpc_cni.arn
}

output "ebs_csi_driver_role_arn" {
  description = "IAM role ARN for EBS CSI driver"
  value       = aws_iam_role.ebs_csi_driver.arn
}

output "efs_csi_driver_role_arn" {
  description = "IAM role ARN for EFS CSI driver"
  value       = try(aws_iam_role.efs_csi_driver[0].arn, null)
}
