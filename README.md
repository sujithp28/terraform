# ☸️ EKS Module

Production-grade Amazon EKS cluster with multi-AZ node groups, OIDC/IRSA, and managed add-ons.

## Features
- EKS cluster with private/public endpoint control
- Three node group types: system, application, GPU (optional)
- OIDC provider for IAM Roles for Service Accounts (IRSA)
- Managed add-ons: VPC CNI, EBS CSI, EFS CSI, CoreDNS, kube-proxy
- KMS encryption for secrets and EBS volumes
- CloudWatch control plane logging

## Quick Start
```bash
cd examples/eks
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars
terraform init && terraform plan && terraform apply
aws eks update-kubeconfig --name <cluster-name> --region us-east-1
```

See `IMPLEMENTATION_GUIDE.md` for full details.
