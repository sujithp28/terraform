# 🏗 Terraform AWS VPC Module

A production-grade, reusable Terraform module for provisioning a complete AWS VPC infrastructure with multi-environment support.

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

## 📐 Architecture

```
VPC (10.0.0.0/16)
├── Public Subnets  (AZ-a, AZ-b, AZ-c)  → Internet Gateway
│     └── NAT Gateway (with Elastic IP)
├── Private Subnets (AZ-a, AZ-b, AZ-c)  → NAT Gateway
└── Security Groups
      ├── Bastion SG    (SSH from allowed CIDRs)
      ├── ALB SG        (HTTP/HTTPS from internet)
      ├── App SG        (traffic from ALB + SSH from Bastion)
      └── RDS SG        (MySQL/PostgreSQL from App SG)
```

---

## ✅ Features

- ✔ Multi-AZ public and private subnets
- ✔ Internet Gateway for public subnets
- ✔ NAT Gateway per AZ (prod) or single NAT (dev/staging) for cost saving
- ✔ Separate security groups for Bastion, ALB, App, and RDS
- ✔ VPC Flow Logs to CloudWatch for observability
- ✔ EKS-ready subnet tags (`kubernetes.io/role/elb`)
- ✔ Full tagging strategy with `common_tags`
- ✔ S3 remote state backend support (prod)
- ✔ Multi-environment: dev / staging / prod

---

## 📁 Folder Structure

```
terraform-aws-vpc/
├── modules/
│   └── vpc/
│       ├── main.tf          # VPC, subnets, IGW, NAT, route tables, SGs, flow logs
│       ├── variables.tf     # All input variables with descriptions & validation
│       └── outputs.tf       # All output values
├── environments/
│   ├── dev/
│   │   ├── main.tf          # Dev-specific config (single NAT, 2 AZs)
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── prod/
│       ├── main.tf          # Prod config (NAT per AZ, 3 AZs, S3 backend)
│       ├── variables.tf
│       └── outputs.tf
├── .gitignore
└── README.md
```

---

## 🚀 Usage

### Deploy Dev Environment

```bash
cd environments/dev

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply
terraform apply
```

### Deploy Prod Environment

```bash
cd environments/prod

# Update backend bucket name in main.tf first
terraform init

terraform plan -out=tfplan
terraform apply tfplan
```

---

## ⚙️ Module Inputs

| Variable | Description | Type | Default |
|---|---|---|---|
| `project` | Project name for resource naming | `string` | - |
| `environment` | Environment (dev/staging/prod) | `string` | - |
| `vpc_cidr` | VPC CIDR block | `string` | `10.0.0.0/16` |
| `availability_zones` | List of AZs | `list(string)` | - |
| `public_subnet_cidrs` | Public subnet CIDRs | `list(string)` | - |
| `private_subnet_cidrs` | Private subnet CIDRs | `list(string)` | - |
| `enable_nat_gateway` | Create NAT Gateways | `bool` | `true` |
| `single_nat_gateway` | Use one NAT GW (cost saving) | `bool` | `false` |
| `enable_flow_logs` | Enable VPC Flow Logs | `bool` | `true` |
| `bastion_allowed_cidrs` | CIDRs allowed for SSH | `list(string)` | `["0.0.0.0/0"]` |
| `common_tags` | Tags applied to all resources | `map(string)` | `{}` |

---

## 📤 Module Outputs

| Output | Description |
|---|---|
| `vpc_id` | VPC ID |
| `vpc_cidr` | VPC CIDR block |
| `public_subnet_ids` | List of public subnet IDs |
| `private_subnet_ids` | List of private subnet IDs |
| `nat_gateway_ids` | List of NAT Gateway IDs |
| `bastion_sg_id` | Bastion Security Group ID |
| `alb_sg_id` | ALB Security Group ID |
| `app_sg_id` | App / EKS worker Security Group ID |
| `rds_sg_id` | RDS Security Group ID |

---

## 🔐 Security Best Practices Applied

- Private subnets have no direct internet access
- RDS only accessible from App security group
- Bastion SSH restricted to specified CIDRs
- VPC Flow Logs enabled for audit trail
- State file encrypted at rest (S3 backend with SSE)
- DynamoDB state locking prevents concurrent applies

---

## 📋 Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- AWS CLI configured with appropriate IAM permissions
- S3 bucket and DynamoDB table for remote state (prod only)

---

## 👤 Author

**Sujith** — Senior DevOps Engineer  
[![GitHub](https://img.shields.io/badge/GitHub-sujithp28-black?style=flat&logo=github)](https://github.com/sujithp28)
