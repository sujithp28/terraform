# 🏗️ Terraform AWS Infrastructure

> **Production-grade, modular AWS infrastructure built with Terraform.**
> Each module lives in its own feature branch and is independently deployable.
> Every branch ships with full Terraform code, examples, security hardening, and an implementation guide.

<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.0-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Modules](https://img.shields.io/badge/Modules-6%20Complete-brightgreen?style=for-the-badge)
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
- [Author](#-author)

---

## 🚀 Quick Start

Get up and running with any module in under 5 minutes:

```bash
# 1. Clone the repository
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# 2. Switch to the module branch you need
git checkout feature/vpc          # VPC + networking (start here)
git checkout feature/eks          # Amazon EKS cluster
git checkout feature/rds          # RDS MySQL / PostgreSQL
git checkout feature/jenkins-cicd # Jenkins CI/CD on EC2
git checkout feature/monitoring   # CloudWatch dashboards & alarms
git checkout feature/s3-iam       # S3 buckets & IAM roles

# 3. Configure variables
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars

# 4. Deploy
terraform init && terraform plan && terraform apply

# 5. View outputs
terraform output
```

> 📖 Each branch contains a detailed `IMPLEMENTATION_GUIDE.md` — read it before deploying.

---

## 📋 Project Overview

This repository provides **six production-ready Terraform modules** covering the full AWS infrastructure stack for a modern cloud-native application.

| Property | Detail |
|----------|--------|
| ✅ **Modular** | Each module is independently deployable — no tight coupling |
| ✅ **Documented** | Every branch has `IMPLEMENTATION_GUIDE.md`, inline comments, and examples |
| ✅ **Secure** | KMS encryption, private subnets, IAM least privilege, IMDSv2 |
| ✅ **Scalable** | Multi-AZ, auto-scaling, multi-environment tfvars |
| ✅ **Observable** | CloudWatch logs, dashboards, and metric alarms built in |
| ✅ **Compliant** | Consistent tagging, audit logs, backup policies, HTTPS-only |

---

## 🌿 Branch Strategy

The `master` branch holds this overview. Every module lives in its own `feature/` branch.

### Active Module Branches

| Branch | Module | Key Resources | Status | Link |
|--------|--------|---------------|--------|------|
| `feature/vpc` | 🌐 AWS VPC | VPC, Subnets (Multi-AZ), IGW, NAT Gateway, Flow Logs | ✅ **Complete** | [View →](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/vpc) |
| `feature/eks` | ☸️ Amazon EKS | EKS Cluster, Node Groups, OIDC/IRSA, Managed Add-ons | ✅ **Complete** | [View →](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/eks) |
| `feature/rds` | 🗄️ AWS RDS | MySQL 8.0 / PostgreSQL 15, Multi-AZ, Read Replicas, Alarms | ✅ **Complete** | [View →](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/rds) |
| `feature/jenkins-cicd` | ⚙️ Jenkins CI/CD | Jenkins EC2, Docker, kubectl, ECR Push, EKS Deploy Pipeline | ✅ **Complete** | [View →](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/jenkins-cicd) |
| `feature/monitoring` | 📊 Monitoring | CloudWatch Alarms, SNS Alerts, Dashboard, Log Groups | ✅ **Complete** | [View →](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/monitoring) |
| `feature/s3-iam` | 🔐 S3 & IAM | S3 Encrypted Bucket, Versioning, Replication, IAM Roles | ✅ **Complete** | [View →](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/s3-iam) |

### Master Branch Files

| File | Purpose |
|------|---------|
| `README.md` | This overview (you are here) |
| `CHANGELOG.md` | Full version history |
| `CONTRIBUTING.md` | Contribution guidelines |
| `LICENSE` | MIT License |
| `.gitignore` | Ignores state, secrets, editor files |

---

## 📊 Project Status

### Overall Progress: **100% Complete** 🎉

| Module | Status | Version | Branch | Last Updated |
|--------|--------|---------|--------|--------------|
| VPC | ✅ Complete | v1.0.0 | `feature/vpc` | 2026-06-24 |
| EKS | ✅ Complete | v1.0.0 | `feature/eks` | 2026-06-24 |
| RDS | ✅ Complete | v1.1.0 | `feature/rds` | 2026-06-24 |
| Jenkins CI/CD | ✅ Complete | v1.0.0 | `feature/jenkins-cicd` | 2026-06-24 |
| Monitoring | ✅ Complete | v1.0.0 | `feature/monitoring` | 2026-06-24 |
| S3 & IAM | ✅ Complete | v1.0.0 | `feature/s3-iam` | 2026-06-24 |

### Changelog Summary

| Date | Version | Change |
|------|---------|--------|
| 2026-06-24 | v1.3.0 | ✅ All 6 modules complete — Jenkins, Monitoring, S3 & IAM pushed |
| 2026-06-24 | v1.2.0 | 📄 Master README overhaul, `.gitignore`, `CONTRIBUTING.md`, `CHANGELOG.md` |
| 2026-06-23 | v1.1.0 | ✅ RDS module — MySQL & PostgreSQL, Multi-AZ, alarms, examples |
| 2026-06-18 | v1.0.0 | ✅ VPC + EKS modules — OIDC/IRSA, managed add-ons, security hardening |

---

## 🏛️ Overall Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                           AWS Account                               │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │                    VPC  (10.0.0.0/16)                        │  │
│  │                                                              │  │
│  │  ┌─────────────────────────┐  ┌──────────────────────────┐  │  │
│  │  │     Public Subnets      │  │     Private Subnets       │  │  │
│  │  │  (1a · 1b · 1c)        │  │  (1a · 1b · 1c)          │  │  │
│  │  │                         │  │                            │  │  │
│  │  │  ┌─────────────────┐   │  │  ┌────────────────────┐   │  │  │
│  │  │  │  ALB / NLB      │   │  │  │   EKS Cluster      │   │  │  │
│  │  │  │  (Ingress)      │   │  │  │  ├─ System Nodes   │   │  │  │
│  │  │  └────────┬────────┘   │  │  │  ├─ App Nodes      │   │  │  │
│  │  │           │             │  │  │  └─ GPU Nodes*     │   │  │  │
│  │  │  ┌────────▼────────┐   │  │  └────────┬───────────┘   │  │  │
│  │  │  │  NAT Gateway    │   │  │           │                 │  │  │
│  │  │  │  (per AZ)       │   │  │  ┌────────▼───────────┐   │  │  │
│  │  │  └─────────────────┘   │  │  │  Jenkins CI/CD      │   │  │  │
│  │  │                         │  │  │  (EC2 + Docker)     │   │  │  │
│  │  │  ┌─────────────────┐   │  │  └────────────────────┘   │  │  │
│  │  │  │ Internet Gateway│   │  │                             │  │  │
│  │  │  └─────────────────┘   │  │  ┌────────────────────┐   │  │  │
│  │  └─────────────────────────┘  │  │  RDS  (Multi-AZ)   │   │  │  │
│  │                                │  │  Primary · Standby  │   │  │  │
│  │                                │  │  + Read Replica     │   │  │  │
│  │                                │  └────────────────────┘   │  │  │
│  │                                └──────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │              S3 & IAM                                        │  │
│  │  • S3 (encrypted, versioned, lifecycle, HTTPS-only)         │  │
│  │  • IAM Roles (app, CI/CD, replication)                      │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │              Monitoring & Observability                       │  │
│  │  • CloudWatch Logs  — EKS, RDS, Jenkins, App                │  │
│  │  • CloudWatch Alarms — CPU, storage, memory, connections     │  │
│  │  • CloudWatch Dashboards — unified infra view               │  │
│  │  • SNS Email Alerts — immediate on-call notification        │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 📦 Module Features

### 🌐 VPC (`feature/vpc`)
- Multi-AZ VPC — 3 public + 3 private subnets across 3 AZs
- Internet Gateway + NAT Gateway (per-AZ or single for cost saving)
- VPC Flow Logs → CloudWatch with configurable retention
- Route tables with correct public/private associations
- Kubernetes ELB subnet tags for ALB Ingress Controller

### ☸️ EKS (`feature/eks`)
- Production EKS cluster with private/public API endpoint control
- Three node group types: **system** (`t3.medium`), **app** (`t3.large`), **GPU** (optional)
- OIDC provider + IRSA — no static credentials in pods
- Managed add-ons: VPC CNI, CoreDNS, kube-proxy, EBS CSI, EFS CSI
- KMS encryption for secrets and EBS volumes
- Control plane logging: API, audit, scheduler, controller → CloudWatch

### 🗄️ RDS (`feature/rds`)
- MySQL 8.0 and PostgreSQL 15 — switch via single variable
- Multi-AZ with automatic failover + optional read replica
- Storage autoscaling (gp3, configurable max)
- KMS at-rest encryption (AWS-managed or customer CMK)
- Enhanced Monitoring (per-process, 1–60s) + Performance Insights
- CloudWatch Alarms: CPU, free storage, free memory, connections
- Custom parameter groups + MySQL option groups

### ⚙️ Jenkins CI/CD (`feature/jenkins-cicd`)
- Jenkins LTS on Amazon Linux 2023 EC2 (private subnet)
- Java 17 + Docker + AWS CLI v2 + kubectl + Helm — auto-installed via userdata
- IAM role: ECR push, EKS describe, S3 read/write, Secrets Manager
- IMDSv2 enforced — no legacy metadata access
- **Jenkinsfile** included: checkout → lint → Docker build → Trivy scan → ECR push → EKS rolling deploy

### 📊 Monitoring (`feature/monitoring`)
- SNS topic + email subscription — confirm once, get all alerts
- CloudWatch Alarms: RDS CPU, free storage, connection count
- CloudWatch Dashboard — all key metrics in a single view
- Application CloudWatch Log Group — centralised app logging

### 🔐 S3 & IAM (`feature/s3-iam`)
- S3 bucket: AES-256 encryption, public access block, HTTPS-only policy
- Versioning + noncurrent version expiry (30 days)
- Lifecycle: Glacier transition after 90 days, object expiry after 365 days
- Optional cross-region replication with dedicated IAM role
- Dynamic IAM roles — configure any number via a single `iam_roles` variable

---

## ⚙️ Prerequisites

### Required Tools

| Tool | Min Version | Install |
|------|------------|---------|
| Terraform | >= 1.0 | [developer.hashicorp.com](https://developer.hashicorp.com/terraform/install) |
| AWS CLI | >= 2.0 | [aws.amazon.com/cli](https://aws.amazon.com/cli/) |
| kubectl | >= 1.20 | [kubernetes.io](https://kubernetes.io/docs/tasks/tools/) |
| Helm | >= 3.0 | [helm.sh](https://helm.sh/docs/intro/install/) |
| jq | any | `brew install jq` / `apt install jq` |

### AWS Requirements
- ✅ Active AWS account with billing enabled
- ✅ IAM user or role with appropriate permissions
- ✅ AWS CLI configured (`aws configure` or environment variables)

### Recommended Deployment Order
Deploy modules in this order to satisfy dependencies:

```
1. feature/vpc          ← all other modules depend on VPC outputs
2. feature/rds          ← needs vpc_id + private subnet IDs
3. feature/eks          ← needs vpc_id + private subnet IDs
4. feature/jenkins-cicd ← needs vpc_id + subnet_id + (optional) eks_cluster_name
5. feature/monitoring   ← needs rds_instance_id + (optional) eks_cluster_name
6. feature/s3-iam       ← standalone, but best deployed after core infra
```

---

## 🚀 Getting Started

### Step 1 — Clone & Configure AWS

```bash
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# Configure AWS credentials
aws configure
aws sts get-caller-identity   # Verify
```

### Step 2 — Start with VPC

```bash
git checkout feature/vpc
cat IMPLEMENTATION_GUIDE.md         # Read before deploying

cd examples/vpc
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars                # Set environment, project, CIDRs

terraform init
terraform validate
terraform plan
terraform apply

terraform output                    # Save vpc_id and subnet_ids for next steps
```

### Step 3 — Deploy Remaining Modules

Each module follows the same pattern:

```bash
git checkout feature/<module-name>
cat IMPLEMENTATION_GUIDE.md
cd examples/<module-name>
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars        # Paste vpc_id / subnet_ids from previous step
terraform init && terraform plan && terraform apply
```

### Step 4 — Verify

```bash
# EKS — configure kubectl
aws eks update-kubeconfig --name <cluster-name> --region us-east-1
kubectl get nodes

# RDS — check instance
aws rds describe-db-instances --db-instance-identifier <identifier>

# Jenkins — get initial password
aws ssm start-session --target <instance-id>
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

---

## 📁 Directory Structure

Each feature branch follows this layout:

```
feature/<module>/
├── README.md                    # Module overview
├── IMPLEMENTATION_GUIDE.md      # Step-by-step deploy instructions
├── .gitignore
│
├── modules/<module>/
│   ├── main.tf                  # Core resources
│   ├── variables.tf             # Input variables (all with descriptions)
│   ├── outputs.tf               # Output values
│   └── terraform.tf             # Provider + version constraints
│
└── examples/<module>/
    ├── main.tf                  # Calls the module
    ├── variables.tf
    ├── outputs.tf
    ├── terraform.tfvars.example # Fill in and rename to terraform.tfvars
    └── backend.tf.example       # S3 remote state template
```

---

## 🔐 IAM Permissions Required

### Minimum Inline Policy

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "TerraformCoreAccess",
    "Effect": "Allow",
    "Action": [
      "eks:*", "ec2:*", "rds:*",
      "iam:CreateRole", "iam:AttachRolePolicy", "iam:DetachRolePolicy",
      "iam:DeleteRole", "iam:GetRole", "iam:PassRole",
      "iam:PutRolePolicy", "iam:ListRolePolicies", "iam:ListAttachedRolePolicies",
      "cloudwatch:*", "logs:*", "kms:*",
      "autoscaling:*", "elasticloadbalancing:*",
      "s3:GetObject", "s3:PutObject", "s3:ListBucket",
      "dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"
    ],
    "Resource": "*"
  }]
}
```

### Recommended AWS Managed Policies

| Policy | Used By |
|--------|---------|
| `AmazonEKSFullAccess` | EKS module |
| `AmazonEC2FullAccess` | VPC, Jenkins modules |
| `AmazonRDSFullAccess` | RDS module |
| `AWSKeyManagementServicePowerUser` | All encrypted resources |
| `CloudWatchFullAccess` | Monitoring module |
| `AmazonS3FullAccess` | S3 & IAM module |

### Production Security Rules
1. Use **IAM roles** — never long-lived access keys
2. **Scope ARNs** to specific resources in production
3. Enable **MFA** on all human IAM users
4. Use **AWS Secrets Manager** for all passwords/tokens
5. Enable **CloudTrail** for full API audit logs

---

## 🏷️ Tagging Strategy

All resources are tagged consistently across every module:

| Tag | Example | Purpose |
|-----|---------|---------|
| `Environment` | `prod` / `staging` / `dev` | Cost allocation by env |
| `Project` | `myapp` | Project identifier |
| `Module` | `eks` / `rds` / `vpc` | Source Terraform module |
| `ManagedBy` | `Terraform` | IaC ownership |
| `Owner` | `platform-team` | Responsible team |
| `CostCenter` | `engineering` | Finance allocation |
| `CreatedDate` | `2026-06-24` | Audit trail |

```hcl
# Applied in every module's examples/*/main.tf
tags = {
  Environment = var.environment
  Project     = var.project
  Module      = "eks"
  ManagedBy   = "Terraform"
  Owner       = "platform-team"
  CostCenter  = "engineering"
  CreatedDate = "2026-06-24"
}
```

---

## 💰 Cost Estimates

> Region: **us-east-1** · On-Demand pricing · Estimates only.

| Module | Key Resources | Est. / Month |
|--------|--------------|-------------|
| VPC | NAT Gateways (3×) + data transfer | ~$100 |
| EKS | Control plane + 6 nodes (`t3.medium`/`t3.large`) | ~$335 |
| RDS | `db.t3.small` Multi-AZ + 100 GB gp3 | ~$240 |
| Jenkins | `t3.large` EC2 + 50 GB gp3 | ~$70 |
| Monitoring | CloudWatch + SNS | ~$5 |
| S3 & IAM | Storage + requests | ~$5 |
| **Total (full stack)** | | **~$755/month** |

💡 **Save 30–40%** with Reserved Instances (1-year, no upfront) on EKS nodes and RDS.
💡 **Dev/staging cost**: use `single_nat_gateway = true`, smaller instance classes, skip read replicas.

---

## 🔒 Security Best Practices

### Network
- All compute (EKS nodes, RDS, Jenkins) in **private subnets**
- ALB/NLB in public subnets as the only internet-facing layer
- **VPC Flow Logs** → CloudWatch for traffic auditing
- Security groups: least-privilege, source-scoped ingress rules

### Data
- **KMS encryption** at rest — EBS, RDS, S3, CloudWatch Logs
- **TLS in transit** — RDS `require_ssl`, S3 HTTPS-only bucket policy
- **S3 versioning** + DynamoDB state lock for Terraform state

### Identity
- **IRSA** — fine-grained IAM-to-pod bindings, no node-level credentials
- **IMDSv2** enforced on Jenkins EC2 (no legacy metadata)
- No `AdministratorAccess` — scoped policies per module

### Secrets
```bash
# Never put passwords in terraform.tfvars
aws secretsmanager create-secret \
  --name "myapp/rds/master-password" \
  --secret-string "$(openssl rand -base64 32)"

# Reference in Terraform
data "aws_secretsmanager_secret_version" "rds_pwd" {
  secret_id = "myapp/rds/master-password"
}
```

---

## 🛠️ Troubleshooting

### Common Errors

| Error | Fix |
|-------|-----|
| `no valid credential sources` | Run `aws configure` or `export AWS_PROFILE=<name>` |
| `Subnet must be in at least 2 AZs` | Ensure `subnet_ids` spans 2+ AZs |
| `DBSubnetGroupNotFoundFault` | Deploy VPC + RDS module in same region; check subnet group |
| `state lock` stuck | `terraform force-unlock <LOCK_ID>` |
| `UnauthorizedOperation` | Add missing IAM action to your role policy |

### Debug Commands

```bash
# Verbose Terraform logging
export TF_LOG=DEBUG
terraform plan 2>&1 | tee debug.log

# EKS cluster health
aws eks describe-cluster --name <name> --region us-east-1
kubectl get nodes -o wide

# RDS status
aws rds describe-db-instances --db-instance-identifier <id>

# Active CloudWatch alarms
aws cloudwatch describe-alarms --state-value ALARM

# Terraform state inspection
terraform state list
terraform state show aws_eks_cluster.main
```

---

## 🗺️ Roadmap

### Q3 2026
- [ ] GitHub Actions CI — `terraform validate` + `tflint` on every PR
- [ ] `terratest` integration tests for VPC, EKS, RDS
- [ ] Karpenter node auto-provisioner module (replaces Cluster Autoscaler)
- [ ] Multi-region DR example (primary + failover)

### Q4 2026
- [ ] Terraform Registry module publishing
- [ ] AWS Config + Security Hub compliance checks
- [ ] AWS Cost Anomaly Detection integration
- [ ] ElastiCache (Redis) module

### Future
- Atlantis / Terraform Cloud for GitOps-style plan & apply
- Service mesh module (AWS App Mesh or Istio)
- Crossplane integration

---

## 🤝 Contributing

1. Fork the repo and create a branch: `git checkout -b feature/my-change`
2. Make changes, then validate:
   ```bash
   terraform fmt -recursive .
   terraform validate
   ```
3. Commit using [Conventional Commits](https://www.conventionalcommits.org/):
   ```
   feat: Add ElastiCache module
   fix: Correct RDS subnet variable default
   docs: Update EKS IRSA section
   ```
4. Open a PR against `master`

See [CONTRIBUTING.md](./CONTRIBUTING.md) for full guidelines.

---

## 👤 Author

**Sujith** — Senior DevOps / Platform Engineer
Specialising in Terraform, Kubernetes, AWS, and cloud-native automation.

<div align="center">

[![GitHub](https://img.shields.io/badge/GitHub-sujithp28-black?style=for-the-badge&logo=github)](https://github.com/sujithp28)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/sujithp)

</div>

---

## 📄 License

MIT License — see [LICENSE](./LICENSE) for details.

---

<div align="center">

**⭐ Star the repo if this helped you — it makes it easier for others to find!**

`master` · 6 modules · Terraform ≥ 1.0 · AWS Provider ≥ 5.0 · Last updated 2026-06-24

</div>
