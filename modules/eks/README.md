# AWS EKS Module

This Terraform module provisions a production-grade Amazon EKS (Elastic Kubernetes Service) cluster with best practices.

## Features

- **Multi-AZ High Availability**: EKS cluster spread across multiple availability zones
- **Multiple Node Groups**:
  - System node group for critical Kubernetes components
  - Application node group for application workloads
  - Optional GPU node group for ML/compute-intensive workloads
- **Security Best Practices**:
  - KMS encryption for EBS volumes
  - Private API endpoint by default with optional public access
  - Security groups with restrictive ingress/egress rules
  - IAM roles with least privilege
  - IRSA (IAM Roles for Service Accounts) support via OIDC provider
- **Comprehensive Logging**:
  - Control plane logs to CloudWatch
  - Configurable log retention
  - KMS-encrypted log groups
- **EKS Add-ons**:
  - VPC CNI for networking
  - CoreDNS for DNS
  - kube-proxy for networking
  - EBS CSI Driver for persistent volumes
  - Optional EFS CSI Driver
- **Monitoring Ready**:
  - CloudWatch Log Group for cluster logs
  - Support for metrics collection

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0
- An existing VPC with private subnets
- At least 2 private subnets in different AZs (recommended)

## Usage

```hcl
module "eks" {
  source = "./modules/eks"

  cluster_name    = "my-cluster"
  kubernetes_version = "1.29"
  vpc_id          = aws_vpc.main.id
  private_subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id,
    aws_subnet.private_3.id
  ]

  # System node group configuration
  system_desired_size   = 3
  system_min_size       = 3
  system_max_size       = 10
  system_instance_types = ["t3.medium"]

  # Application node group configuration
  enable_application_node_group = true
  application_desired_size      = 3
  application_min_size          = 1
  application_max_size          = 20
  application_instance_types    = ["t3.large"]

  # Optional GPU node group
  enable_gpu_node_group = false

  # Logging and encryption
  cluster_enabled_log_types   = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_log_retention_in_days = 30

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Inputs

### Required

- `cluster_name` - Name of the EKS cluster (1-100 characters, alphanumeric and hyphens only)
- `vpc_id` - VPC ID where the cluster will be created
- `private_subnet_ids` - List of at least 2 private subnet IDs for cluster placement

### Optional (with defaults)

- `kubernetes_version` - Kubernetes version (default: 1.29)
- `system_desired_size` - System node group desired size (default: 3)
- `application_desired_size` - Application node group desired size (default: 3)
- `enable_gpu_node_group` - Enable GPU node group (default: false)
- `cluster_log_retention_in_days` - CloudWatch log retention (default: 30)
- `endpoint_private_access` - Enable private API endpoint (default: true)
- `endpoint_public_access` - Enable public API endpoint (default: true)
- See `variables.tf` for complete list

## Outputs

- `cluster_id` - EKS cluster ID
- `cluster_arn` - EKS cluster ARN
- `cluster_endpoint` - EKS cluster endpoint
- `cluster_version` - Kubernetes version
- `cluster_security_group_id` - Security group for cluster
- `node_security_group_id` - Security group for nodes
- `cluster_oidc_issuer_url` - OIDC issuer URL for IRSA
- `oidc_provider_arn` - OIDC provider ARN
- `cloudwatch_log_group_name` - CloudWatch log group name
- See `outputs.tf` for complete list

## Security Considerations

1. **API Endpoint Access**: By default, the cluster uses private endpoint access with public disabled. Adjust `endpoint_public_access` and `public_access_cidrs` as needed.
2. **Network Access**: Nodes are placed in private subnets and require NAT gateway for outbound internet access.
3. **IAM**: Each component has its own IAM role with least privilege permissions.
4. **Encryption**: All data is encrypted using KMS keys.
5. **IRSA**: The module creates an OIDC provider to support IAM roles for Kubernetes service accounts.

## Advanced Features

### IRSA (IAM Roles for Service Accounts)

Use the `cluster_oidc_issuer_url` output to create service account roles:

```hcl
resource "aws_iam_role" "app_role" {
  name = "my-app-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = module.eks.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:default:my-app-sa"
        }
      }
    }]
  })
}
```

### Multiple Node Groups

The module creates separate node groups for different workload types:
- System nodes run Kubernetes system components
- Application nodes run user applications
- GPU nodes (optional) run compute-intensive workloads

### Custom Tags

All resources support custom tags:

```hcl
tags = {
  Environment = "production"
  CostCenter  = "engineering"
  Owner       = "platform-team"
}
```

## Troubleshooting

1. **Nodes not joining cluster**: Check security groups and IAM roles
2. **Pod networking issues**: Verify VPC CNI is deployed and configured
3. **Persistent volume issues**: Ensure EBS CSI driver is deployed
4. **IRSA issues**: Verify OIDC provider ARN and service account annotations

## References

- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [EKS Best Practices Guide](https://aws.github.io/aws-eks-best-practices/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
