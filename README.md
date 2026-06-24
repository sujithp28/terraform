# 🌐 VPC Module

Production-grade AWS VPC with multi-AZ subnets, NAT Gateways, and VPC Flow Logs.

## Features
- Multi-AZ public & private subnets (3 AZs)
- Internet Gateway + NAT Gateways (one per AZ or single)
- VPC Flow Logs → CloudWatch
- Route tables with proper associations
- Kubernetes subnet tagging for EKS load balancers

## Quick Start
```bash
cd examples/vpc
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars
terraform init && terraform plan && terraform apply
```

See `IMPLEMENTATION_GUIDE.md` for full details.
