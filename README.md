# 🏗️ Terraform AWS Infrastructure

> **Production-grade, modular AWS infrastructure built with Terraform.**
> Each module lives in its own branch and is independently deployable.
> Complete with documentation, examples, security hardening, and best practices.

<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.0-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Last Updated](https://img.shields.io/badge/Last%20Updated-June%202026-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

</div>

---

## 📚 Table of Contents

- [Quick Start](#-quick-start)
- [Project Overview](#-project-overview)
- [Branch Strategy](#-branch-strategy)
- [Project Status](#-project-status)
- [Overall Architecture](#-overall-architecture)
- [Module Features](#-module-features)
- [Prerequisites](#️-prerequisites)
- [Getting Started](#-getting-started)
- [Directory Structure](#-directory-structure)
- [IAM Permissions](#-iam-permissions-required)
- [Tagging Strategy](#️-tagging-strategy)
- [Cost Estimates](#-cost-estimates)
- [Security Best Practices](#-security-best-practices)
- [Troubleshooting](#-troubleshooting)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [Documentation](#-documentation)
- [Support](#-support)
- [Author](#-author)

---

## 🚀 Quick Start

Get started with any module in under 5 minutes:

```bash
# 1. Clone the repository
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# 2. Switch to your desired module branch
git checkout feature/eks          # Amazon EKS cluster
git checkout feature/vpc          # VPC + networking
git checkout feature/rds          # RDS database

# 3. Navigate to the examples directory
cd examples/eks                   # (or vpc, rds, etc.)

# 4. Configure your variables
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars              # Fill in your values

# 5. Deploy
terraform init
terraform plan
terraform apply

# 6. View outputs
terraform output
```

For detailed instructions, see `IMPLEMENTATION_GUIDE.md` in each branch.

---

## 📋 Project Overview

This repository contains **production-ready Terraform modules** for AWS infrastructure. Each module is:

| Property | Description |
|----------|-------------|
| ✅ **Modular** | Independently deployable; no tight coupling between modules |
| ✅ **Documented** | Comprehensive guides, inline comments, and examples |
| ✅ **Secure** | IAM least privilege, KMS encryption, private endpoints |
| ✅ **Scalable** | Multi-AZ, auto-scaling, and multi-environment support |
| ✅ **Observable** | CloudWatch logging, dashboards, and metric alarms |
| ✅ **Compliant** | Tagging strategy, audit logs, and backup policies |

---

## 🌿 Branch Strategy

Each infrastructure component lives in its own branch. The `master` branch holds this overview only.

### Module Branches

| Branch | Module | Description | Status | Link |
|--------|--------|-------------|--------|------|
| `feature/vpc` | 🌐 AWS VPC | VPC, Subnets, IGW, NAT Gateway, Security Groups, Route Tables | ✅ Ready | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/vpc) |
| `feature/eks` | ☸️ Amazon EKS | EKS Cluster, Node Groups, OIDC/IRSA, Managed Add-ons | ✅ Ready | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/eks) |
| `feature/rds` | 🗄️ AWS RDS | RDS MySQL/PostgreSQL, Multi-AZ, Read Replicas, CloudWatch Alarms | ✅ Ready | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/rds) |
| `feature/jenkins-cicd` | ⚙️ Jenkins CI/CD | Jenkins on EC2, Pipeline as Code, Docker Integration, EKS Deploy | 🚧 In Progress | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/jenkins-cicd) |
| `feature/monitoring` | 📊 Monitoring | Dynatrace + CloudWatch, Dashboards, Metric Alarms | 🔜 Planned | Coming Soon |
| `feature/s3-iam` | 🔐 S3 & IAM | S3 Buckets, IAM Roles, Policies, Versioning, Replication | 🔜 Planned | Coming Soon |

---

## 📊 Project Status

### Overall Progress: **65% Complete**

| Component | Status | Version | Last Updated |
|-----------|--------|---------|--------------|
| VPC Module | ✅ Ready | v1.0.0 | 2026-06-18 |
| EKS Module | ✅ Ready | v1.0.0 | 2026-06-18 |
| RDS Module | ✅ Ready | v1.1.0 | 2026-06-23 |
| Jenkins Module | 🚧 In Progress | v0.5.0 | 2026-06-10 |
| Monitoring | 🔜 Planned | - | - |
| S3 & IAM | 🔜 Planned | - | - |

### Recent Updates

| Date | Change |
|------|--------|
| 2026-06-24 | 📄 Master README overhaul — improved structure, security, troubleshooting & roadmap |
| 2026-06-23 | ✅ RDS module production-ready (MySQL & PostgreSQL, Multi-AZ, read replicas, CloudWatch alarms) |
| 2026-06-23 | ✅ RDS `IMPLEMENTATION_GUIDE.md` and complete examples added |
| 2026-06-18 | ✅ Production-grade EKS module with comprehensive documentation |
| 2026-06-18 | ✅ EKS add-ons: VPC CNI, EBS CSI, EFS CSI, CoreDNS |
| 2026-06-17 | ✅ Initial VPC module with multi-AZ support |

---

## 🏛️ Overall Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                          AWS Account                                 │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌───────────────────────────────────────────────────────────────┐   │
│  │                      VPC (10.0.0.0/16)                        │   │
│  │                                                               │   │
│  │  ┌──────────────────────────┐   ┌─────────────────────────┐  │   │
│  │  │     Public Subnets       │   │    Private Subnets       │  │   │
│  │  │  (us-east-1a, 1b, 1c)   │   │  (us-east-1a, 1b, 1c)  │  │   │
│  │  │                          │   │                          │  │   │
│  │  │  ┌────────────────────┐  │   │  ┌──────────────────┐   │  │   │
│  │  │  │   ALB / NLB        │  │   │  │   EKS Cluster    │   │  │   │
│  │  │  │   (Ingress)        │  │   │  │  - System Nodes  │   │  │   │
│  │  │  └────────┬───────────┘  │   │  │  - App Nodes     │   │  │   │
│  │  │           │               │   │  │  - GPU Nodes*    │   │  │   │
│  │  │  ┌────────▼───────────┐  │   │  └────────┬─────────┘   │  │   │
│  │  │  │   NAT Gateway      │  │   │           │               │  │   │
│  │  │  │   (IGW Route)      │  │   │  ┌────────▼───────────┐  │  │   │
│  │  │  └────────────────────┘  │   │  │   Jenkins CI/CD    │  │  │   │
│  │  │                          │   │  │   (Pipeline Host)  │  │  │   │
│  │  │  ┌────────────────────┐  │   │  └────────────────────┘  │  │   │
│  │  │  │  Internet Gateway  │  │   │                          │  │   │
│  │  │  │  (0.0.0.0/0)       │  │   │  ┌──────────────────┐   │  │   │
│  │  │  └────────────────────┘  │   │  │  RDS (Multi-AZ)  │   │  │   │
│  │  └──────────────────────────┘   │  │ Primary: 1a      │   │  │   │
│  │                                  │  │ Standby: 1b      │   │  │   │
│  │                                  │  └──────────────────┘   │  │   │
│  │                                  └─────────────────────────┘  │   │
│  └───────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌───────────────────────────────────────────────────────────────┐   │
│  │               Monitoring & Observability                      │   │
│  │  • CloudWatch Logs  (EKS, RDS, Jenkins, Application)         │   │
│  │  • CloudWatch Dashboards & Metric Alarms                     │   │
│  │  • AWS X-Ray (Optional tracing)                              │   │
│  │  • Dynatrace Integration (Optional APM)                      │   │
│  └───────────────────────────────────────────────────────────────┘   │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 📦 Module Features

### 🌐 VPC Module
- Multi-AZ VPC with public and private subnets (3 AZs)
- NAT Gateway for private subnet outbound access
- Internet Gateway for public internet access
- Network ACLs and Security Groups (least privilege)
- VPC Flow Logs for network visibility
- DNS support, DNS hostnames enabled
- Configurable CIDR blocks per environment

### ☸️ EKS Module
- **Production-grade EKS cluster** with Kubernetes best practices
- **Multi-AZ node groups** for high availability
- **Three node group types**:
  - System nodes (3 × `t3.medium`, dedicated system workloads)
  - Application nodes (auto-scaling, `t3.large`)
  - GPU nodes (optional, for ML/AI workloads)
- **Security hardening**:
  - KMS encryption for EBS volumes and secrets
  - Private API endpoint (public endpoint optional)
  - Security groups with least-privilege ingress/egress
  - IRSA (IAM Roles for Service Accounts) via OIDC
- **Managed add-ons**:
  - VPC CNI — pod networking
  - CoreDNS — service discovery
  - kube-proxy — network routing
  - EBS CSI Driver — persistent volumes
  - EFS CSI Driver (optional) — shared file storage
- **Comprehensive logging** to CloudWatch (API, audit, scheduler, controller)
- **OIDC provider** for fine-grained IAM-to-pod role binding

### 🗄️ RDS Module
- **Multi-engine support**: MySQL 8.0 and PostgreSQL 15
- **Multi-AZ deployment** — automatic failover, zero RPO design
- **Read replicas** — horizontal read scaling
- **Storage autoscaling** with configurable max threshold
- **KMS encryption** at rest (AWS-managed or customer-managed key)
- **Enhanced Monitoring** — per-process metrics at 1–60s granularity
- **Performance Insights** — query-level analysis and wait event breakdown
- **CloudWatch Alarms**: CPU utilisation, free storage, free memory, connections
- **Custom parameter groups** (MySQL & PostgreSQL engine-specific tuning)
- **Option groups** for MySQL advanced features (audit plugin, etc.)
- **Security groups** — CIDR and SG-based ingress with description tags

### ⚙️ Jenkins CI/CD Module *(In Progress)*
- Jenkins EC2 instance with automated provisioning
- Pipeline as Code (Jenkinsfile) support
- Docker daemon integration
- Blue/Green deployment pattern
- EKS `kubectl` integration for K8s deployments
- Secrets management via AWS Secrets Manager
- Webhook support for GitHub/GitLab events
- Parameterised pipelines for multi-environment deploys

---

## ⚙️ Prerequisites

### Required Software

| Tool | Minimum Version | Install Link |
|------|----------------|--------------|
| Terraform | >= 1.0 | [hashicorp.com](https://developer.hashicorp.com/terraform/install) |
| AWS CLI | >= 2.0 | [aws.amazon.com](https://aws.amazon.com/cli/) |
| kubectl | >= 1.20 | [kubernetes.io](https://kubernetes.io/docs/tasks/tools/) |
| Helm | >= 3.0 | [helm.sh](https://helm.sh/docs/intro/install/) |
| jq | Any | `brew install jq` / `apt install jq` |

### AWS Account Requirements

- ✅ Active AWS account with billing enabled
- ✅ IAM user/role with appropriate permissions (see [IAM Permissions](#-iam-permissions-required))
- ✅ VPC with 2–3 private subnets (for EKS/RDS deployments)
- ✅ NAT Gateway configured for private subnet egress
- ✅ Internet Gateway attached for public subnets

### System Requirements

| Platform | Minimum Version |
|----------|----------------|
| macOS | 10.14+ |
| Linux | Ubuntu 20.04 LTS |
| Windows | WSL2 with Ubuntu 20.04 |
| Memory | 4 GB (local testing) |
| Disk Space | 10 GB |

---

## 🚀 Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# Confirm you're on master
git branch
```

### Step 2: Configure AWS Credentials

```bash
# Option A: AWS CLI interactive setup
aws configure

# Option B: Environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"

# Verify
aws sts get-caller-identity
```

### Step 3: Choose a Module

```bash
# View all available branches
git branch -r

# Checkout the module you need
git checkout feature/eks     # Amazon EKS
git checkout feature/vpc     # AWS VPC
git checkout feature/rds     # AWS RDS
```

### Step 4: Read the Module Guide

Each module branch includes:

| File/Directory | Purpose |
|----------------|---------|
| `IMPLEMENTATION_GUIDE.md` | Step-by-step deployment instructions |
| `examples/` | Ready-to-use configurations per environment |
| `modules/` | Reusable Terraform module source |
| `README.md` | Module-specific reference documentation |

```bash
# Read the guide before deploying
cat IMPLEMENTATION_GUIDE.md
ls -la examples/
```

### Step 5: Deploy

```bash
cd examples/eks                      # Navigate to your module's examples

cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars                 # Set your values

terraform init                       # Download providers & modules
terraform validate                   # Validate configuration syntax
terraform fmt -recursive .           # Auto-format code
terraform plan                       # Preview changes
terraform apply                      # Deploy

terraform output                     # View outputs after deploy
```

---

## 📁 Directory Structure

```
terraform-aws-infrastructure/
├── README.md                          # This file (master overview)
├── CONTRIBUTING.md                    # Contribution guidelines
├── CHANGELOG.md                       # Version history
├── LICENSE                            # MIT License
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf                    # VPC, subnets, IGW, NAT, NACLs
│   │   ├── variables.tf               # Input variables
│   │   ├── outputs.tf                 # Output values
│   │   └── README.md
│   │
│   ├── eks/
│   │   ├── main.tf                    # EKS cluster
│   │   ├── node_groups.tf             # System, app, GPU node groups
│   │   ├── addons.tf                  # VPC CNI, EBS CSI, CoreDNS, etc.
│   │   ├── oidc.tf                    # OIDC provider for IRSA
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tf               # Provider + version constraints
│   │   └── README.md
│   │
│   ├── rds/
│   │   ├── main.tf                    # RDS instance, SG, param groups, alarms
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tf
│   │   └── README.md
│   │
│   └── jenkins/
│       └── ...                        # Coming soon
│
├── examples/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars.example
│   │   └── backend.tf.example
│   │
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars.example
│   │   └── backend.tf.example
│   │
│   └── rds/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── terraform.tfvars.example
│       └── backend.tf.example
│
└── .gitignore
```

---

## 🔐 IAM Permissions Required

### Minimum Inline Policy

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "TerraformCoreAccess",
      "Effect": "Allow",
      "Action": [
        "eks:*",
        "ec2:*",
        "rds:*",
        "iam:CreateRole",
        "iam:AttachRolePolicy",
        "iam:DetachRolePolicy",
        "iam:DeleteRole",
        "iam:GetRole",
        "iam:PassRole",
        "iam:PutRolePolicy",
        "iam:ListRolePolicies",
        "iam:ListAttachedRolePolicies",
        "cloudwatch:*",
        "logs:*",
        "kms:*",
        "autoscaling:*",
        "elasticloadbalancing:*",
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "*"
    }
  ]
}
```

> **Note**: The `s3` and `dynamodb` permissions are required for Terraform remote state (S3 backend + DynamoDB lock table).

### Recommended AWS Managed Policies

| Policy | Purpose |
|--------|---------|
| `AmazonEKSFullAccess` | EKS cluster management |
| `AmazonEC2FullAccess` | VPC, EC2, security groups |
| `AmazonRDSFullAccess` | RDS instances and parameter groups |
| `AWSKeyManagementServicePowerUser` | KMS key management |
| `CloudWatchFullAccess` | Logs, dashboards, alarms |
| `AWSCloudFormationFullAccess` | CloudFormation (used by EKS) |

### ⚠️ Production Recommendations

1. Use **IAM roles** instead of long-lived access keys
2. **Scope resource ARNs** — avoid `"Resource": "*"` in production
3. Enable **MFA** for all console and CLI access
4. Rotate credentials regularly; use **AWS Secrets Manager**
5. Enable **CloudTrail** for full API audit logging
6. Use **VPC endpoints** for S3, DynamoDB, and ECR (no public internet)
7. Apply **permission boundaries** to restrict privilege escalation

---

## 🏷️ Tagging Strategy

All resources are tagged consistently for cost allocation, compliance, and management:

| Tag Key | Example Value | Description |
|---------|---------------|-------------|
| `Environment` | `prod` / `staging` / `dev` | Deployment environment |
| `Project` | `myapp` | Project or product identifier |
| `Module` | `eks` / `vpc` / `rds` | Source Terraform module |
| `ManagedBy` | `Terraform` | IaC tool identifier |
| `Owner` | `platform-team` | Responsible team or person |
| `CostCenter` | `engineering` | Billing/cost allocation code |
| `CreatedDate` | `2026-06-24` | ISO-8601 creation date |

### Tag Example (HCL)

```hcl
tags = {
  Environment = "production"
  Project     = "myapp"
  Module      = "rds"
  ManagedBy   = "Terraform"
  Owner       = "platform-team"
  CostCenter  = "engineering"
  CreatedDate = "2026-06-24"
}
```

---

## 💰 Cost Estimates

> All estimates are for **us-east-1**. Actual costs vary by region, traffic, and usage.

### EKS Cluster

| Component | Type | Est. Cost/Month |
|-----------|------|----------------|
| EKS Control Plane | Managed | $73.00 |
| System Nodes (3 × `t3.medium`) | EC2 On-Demand | ~$50.00 |
| App Nodes (3 × `t3.large`) | EC2 On-Demand | ~$150.00 |
| NAT Gateway | Per hour + data | ~$32.00 |
| CloudWatch Logs | Ingestion + storage | ~$10.00 |
| EBS Volumes | gp3 storage | ~$20.00 |
| **Minimum Total** | | **~$335/month** |

### VPC + Networking

| Component | Est. Cost/Month |
|-----------|----------------|
| VPC, Subnets, Route Tables | Free |
| NAT Gateway | ~$32.00 |
| Data Transfer | ~$10.00 |
| **Total** | **~$42/month** |

### RDS (MySQL, Multi-AZ)

| Component | Est. Cost/Month |
|-----------|----------------|
| `db.t3.small` Multi-AZ | ~$200.00 |
| Storage (100 GB gp3) | ~$25.00 |
| Automated Backup Storage | ~$10.00 |
| Data Transfer | ~$5.00 |
| **Total** | **~$240/month** |

💡 **Tip**: Use **Reserved Instances** (1-year, no upfront) for 30–40% savings on stable workloads.

---

## 🔒 Security Best Practices

### Network Security
- All compute (EKS nodes, RDS) runs in **private subnets** — no direct internet exposure
- Security groups follow **least privilege**: only required ports, source-scoped rules
- **VPC Flow Logs** enabled for traffic auditing
- **NACLs** as an additional stateless defence layer

### Data Security
- **KMS encryption** at rest for EBS, RDS, and CloudWatch Logs
- **TLS in transit** enforced for RDS connections (`require_ssl` parameter)
- **S3 bucket versioning** and object-level logging for state files
- **DynamoDB state lock** to prevent concurrent Terraform runs

### Identity & Access
- **IRSA (IAM Roles for Service Accounts)** — no static credentials in pods
- **OIDC federation** between EKS and IAM
- IAM roles use **condition keys** to scope to specific namespaces/service accounts
- Avoid `AdministratorAccess`; use scoped policies per module

### Secrets Management
```bash
# Store secrets in AWS Secrets Manager, not in .tfvars
aws secretsmanager create-secret \
  --name "myapp/rds/password" \
  --secret-string "$(openssl rand -base64 32)"

# Reference in Terraform
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = "myapp/rds/password"
}
```

---

## 🛠️ Troubleshooting

### Common Issues

#### `Error: configuring Terraform AWS Provider: no valid credential sources`
```bash
# Verify credentials are set
aws sts get-caller-identity

# Re-configure if needed
aws configure
# or
export AWS_PROFILE=your-profile
```

#### `Error: creating EKS Cluster: InvalidParameterException: Subnet must be in at least 2 different AZs`
```hcl
# Ensure subnet_ids spans 2+ AZs in your module call
subnet_ids = [
  "subnet-aaa111",  # us-east-1a
  "subnet-bbb222",  # us-east-1b
  "subnet-ccc333",  # us-east-1c
]
```

#### `Error: creating DB Instance: DBSubnetGroupNotFoundFault`
```bash
# Verify the subnet group exists
aws rds describe-db-subnet-groups --region us-east-1
```

#### Terraform state lock stuck
```bash
# List and remove a stuck lock (replace LOCK_ID)
terraform force-unlock LOCK_ID
```

### Debug Logging

```bash
# Enable verbose Terraform logging
export TF_LOG=DEBUG
terraform plan 2>&1 | tee terraform-debug.log

# Check CloudWatch logs for EKS control plane
aws logs describe-log-groups --log-group-name-prefix "/aws/eks"

# Inspect current Terraform state
terraform state list
terraform state show aws_eks_cluster.main
```

### Useful AWS CLI Commands

```bash
# Check EKS cluster status
aws eks describe-cluster --name my-cluster --region us-east-1

# Update kubeconfig after EKS deploy
aws eks update-kubeconfig --name my-cluster --region us-east-1

# Check RDS instance status
aws rds describe-db-instances --db-instance-identifier my-db

# List CloudWatch alarms
aws cloudwatch describe-alarms --state-value ALARM
```

---

## 🗺️ Roadmap

### Q3 2026 (July – September)
- [ ] ✅ Complete Jenkins CI/CD module (`feature/jenkins-cicd`)
- [ ] 🔐 S3 & IAM module with bucket policies and cross-account replication
- [ ] 📊 Monitoring module: CloudWatch dashboards + Dynatrace agent
- [ ] 🧪 Automated `terratest` integration tests for VPC, EKS, RDS

### Q4 2026 (October – December)
- [ ] 🌍 Multi-region DR (disaster recovery) example
- [ ] 🔁 GitHub Actions CI pipeline for `terraform validate` + `tflint`
- [ ] 📦 Terraform Registry module publishing
- [ ] 💸 AWS Cost Anomaly Detection integration
- [ ] 🔑 AWS Config + Security Hub integration for compliance checks

### Future Ideas
- Atlantis or Terraform Cloud remote execution
- Crossplane integration for GitOps-native infra management
- Service mesh (AWS App Mesh / Istio) module
- Karpenter node auto-provisioner for EKS

---

## 📖 Documentation

### In This Repository
| Document | Location |
|----------|----------|
| Master Overview | `master` branch → `README.md` (this file) |
| VPC Guide | `feature/vpc` branch → `IMPLEMENTATION_GUIDE.md` |
| EKS Guide | `feature/eks` branch → `IMPLEMENTATION_GUIDE.md` |
| RDS Guide | `feature/rds` branch → `IMPLEMENTATION_GUIDE.md` |
| Changelog | `master` branch → `CHANGELOG.md` |
| Contributing | `master` branch → `CONTRIBUTING.md` |

### External Resources
- [AWS EKS Best Practices](https://aws.github.io/aws-eks-best-practices/)
- [AWS RDS Documentation](https://docs.aws.amazon.com/rds/)
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)

---

## 🤝 Contributing

Contributions are welcome! Here's how to get involved:

### Before You Start
1. Fork the repository
2. Create a branch: `git checkout -b feature/my-improvement`
3. Read `CONTRIBUTING.md` for code style and review guidelines

### Development Workflow

```bash
# After making changes
terraform validate
terraform fmt -check -recursive .
tflint --recursive                  # Install: brew install tflint

# Commit with conventional messages
git commit -m "feat: Add ElastiCache module skeleton"
git commit -m "fix: Correct RDS multi-AZ variable default"
git commit -m "docs: Improve EKS IRSA section in README"

# Push and open a PR
git push origin feature/my-improvement
```

### Commit Message Format

```
<type>(<scope>): <subject>

<body>            # Optional: explain why, not what

<footer>          # Optional: closes #123, breaking changes
```

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## 🎯 Terraform Best Practices

### Code Quality
- ✅ Always run `terraform fmt` before committing
- ✅ Run `terraform validate` in CI before merge
- ✅ Add `description` to every variable and output
- ✅ Use `validation {}` blocks to catch bad inputs early
- ✅ Pin provider versions in `terraform.tf`

### State Management
- ✅ Use **remote state** (S3 backend + DynamoDB lock)
- ✅ One state file per environment (`dev.tfstate`, `prod.tfstate`)
- ✅ Never commit `.tfstate` files to git
- ✅ Enable **S3 versioning** on your state bucket

### AWS Standards
- ✅ Multi-AZ for all stateful resources (RDS, ElastiCache)
- ✅ Encryption at rest and in transit everywhere
- ✅ Use private subnets for all compute and data tiers
- ✅ CloudTrail + Config enabled in all accounts
- ✅ Tag every resource using the standard tag set

---

## 🆘 Support

### Getting Help

1. **Read the docs first**: `IMPLEMENTATION_GUIDE.md` in the relevant branch
2. **Enable debug logging**: `TF_LOG=DEBUG terraform plan`
3. **Check existing issues**: [GitHub Issues](https://github.com/sujithp28/terraform-aws-infrastructure/issues)
4. **Open a new issue** with the template below

### Bug Report Template

```markdown
## Description
Brief summary of the problem.

## Expected Behaviour
What should happen.

## Actual Behaviour
What actually happens (include full error output).

## Steps to Reproduce
1. `git checkout feature/rds`
2. `cd examples/rds`
3. `terraform apply`
4. Error appears: ...

## Environment
- Terraform: vX.X.X (`terraform version`)
- AWS CLI: vX.X.X (`aws --version`)
- AWS Region: us-east-1
- Module: rds / eks / vpc

## Additional Context
Sanitised logs, screenshots, etc.
```

---

## 📝 Changelog

See [CHANGELOG.md](./CHANGELOG.md) for the full version history.

### Latest: v1.2.0 — 2026-06-24
- 📄 Master README overhauled: security section, troubleshooting guide, roadmap, improved architecture diagram

### v1.1.0 — 2026-06-23
- ✅ RDS module production-ready (MySQL & PostgreSQL, Multi-AZ, read replicas, CloudWatch alarms)
- ✅ Complete RDS examples and `IMPLEMENTATION_GUIDE.md`

### v1.0.0 — 2026-06-18
- ✅ EKS module production-ready with OIDC/IRSA and managed add-ons
- ✅ VPC module with multi-AZ support
- ✅ Security best practices throughout

---

## 👤 Author

**Sujith** — Senior DevOps Engineer
Passionate about Infrastructure as Code, Kubernetes, cloud-native architecture, and automation.

<div align="center">

[![GitHub](https://img.shields.io/badge/GitHub-sujithp28-black?style=flat&logo=github)](https://github.com/sujithp28)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Sujith%20P-blue?style=flat&logo=linkedin)](https://linkedin.com/in/sujithp)
[![Email](https://img.shields.io/badge/Email-Contact-red?style=flat&logo=gmail)](mailto:sujith@example.com)

</div>

---

## 📄 License

This project is licensed under the **MIT License** — see [LICENSE](./LICENSE) for details.

---

## 🙏 Acknowledgments

- AWS for comprehensive documentation and managed services
- HashiCorp for Terraform and the AWS provider
- Kubernetes and CNCF community for standards and tooling
- All contributors and users who provide feedback

---

<div align="center">

**⭐ Found this useful? Star the repo — it helps others discover it!**

**Last Updated**: 2026-06-24 | **Terraform**: >= 1.0 | **AWS Provider**: >= 5.0

</div>
