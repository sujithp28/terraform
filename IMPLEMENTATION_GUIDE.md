# VPC Module — Implementation Guide

## Overview
This module creates a production-grade AWS VPC with:
- Multi-AZ public and private subnets
- Internet Gateway
- NAT Gateways (one per AZ or shared)
- VPC Flow Logs → CloudWatch
- Route Tables with proper associations

## Prerequisites
- Terraform >= 1.0
- AWS CLI configured (`aws configure`)
- IAM permissions: `ec2:*`, `logs:*`, `iam:*`

## Quick Deploy

```bash
cd examples/vpc
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars        # Set your values
terraform init
terraform plan
terraform apply
```

## Cost Saving Tips
- Set `single_nat_gateway = true` for dev/staging (~$32/month per NAT Gateway saved)
- Set `enable_flow_logs = false` if not required for compliance

## Outputs Used by Other Modules
- `vpc_id` — required by EKS and RDS modules
- `private_subnet_ids` — used for EKS nodes and RDS instances
- `public_subnet_ids` — used for load balancers

## Destroy
```bash
terraform destroy
```
