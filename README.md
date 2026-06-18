# 🏗 Terraform AWS Infrastructure

> **Production-grade, modular AWS infrastructure built with Terraform.**  
> Each module is maintained in its own branch and independently deployable.  
> Complete with documentation, examples, and best practices.

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

## 📚 Table of Contents

- [Quick Start](#quick-start)
- [Project Overview](#project-overview)
- [Branch Strategy](#branch-strategy)
- [Project Status](#project-status)
- [Architecture](#overall-architecture)
- [Module Features](#module-features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Directory Structure](#directory-structure)
- [IAM Permissions](#iam-permissions-required)
- [Tagging Strategy](#tagging-strategy)
- [Cost Estimates](#cost-estimates)
- [Contributing](#contributing)
- [Documentation](#documentation)
- [Support](#support)
- [Author](#author)

---

## 🚀 Quick Start

Get started with any module in 5 minutes:

```bash
# 1. Clone the repository
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# 2. Switch to your desired module branch
git checkout feature/eks                    # For EKS cluster
# or
git checkout feature/vpc                    # For VPC setup
# or
git checkout feature/rds                    # For RDS database

# 3. Navigate to examples directory
cd examples/eks                             # or vpc, rds, etc.

# 4. Configure your variables
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your settings
vim terraform.tfvars

# 5. Deploy
terraform init
terraform plan
terraform apply

# 6. View outputs
terraform output
```

For detailed instructions, see [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md) in each branch.

---

## 📋 Project Overview

This repository contains production-ready Terraform modules for AWS infrastructure. Each module is:

✅ **Modular** - Independently deployable  
✅ **Documented** - Comprehensive guides and examples  
✅ **Tested** - Best practices and security hardening  
✅ **Scalable** - Multi-environment support (dev, staging, prod)  
✅ **Secure** - IAM roles, KMS encryption, security groups  
✅ **Observable** - CloudWatch logging and monitoring  

---

## 🌿 Branch Strategy

Each infrastructure module lives in its own branch. The `master` branch contains this overview only.

### Module Branches

| Branch | Module | Description | Status | Link |
|--------|--------|-------------|--------|------|
| `feature/vpc` | 🌐 AWS VPC | VPC, Subnets, IGW, NAT, Security Groups, Route Tables | ✅ Ready | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/vpc) |
| `feature/eks` | ☸️ Amazon EKS | EKS Cluster, Node Groups, IAM Roles, Add-ons, Security | ✅ Ready | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/eks) |
| `feature/rds` | 🗄️ AWS RDS | RDS MySQL/PostgreSQL, Multi-AZ, Backup, Security Groups | 🚧 In Progress | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/rds) |
| `feature/jenkins-cicd` | ⚙️ Jenkins CI/CD | Jenkins EC2, Pipeline as Code, Docker Integration | 🚧 In Progress | [View Branch](https://github.com/sujithp28/terraform-aws-infrastructure/tree/feature/jenkins-cicd) |
| `feature/monitoring` | 📊 Monitoring | Dynatrace + CloudWatch, Dashboards, Alerts, Metrics | 🔜 Planned | Coming Soon |
| `feature/s3-iam` | 🔐 S3 & IAM | S3 Buckets, IAM Roles, Policies, Bucket Versioning | 🔜 Planned | Coming Soon |

---

## 📊 Project Status

### Overall Progress: **40% Complete**

| Component | Status | Version | Last Updated |
|-----------|--------|---------|--------------|
| VPC Module | ✅ Ready | v1.0.0 | 2026-06-18 |
| EKS Module | ✅ Ready | v1.0.0 | 2026-06-18 |
| RDS Module | 🚧 In Progress | v0.5.0 | 2026-06-15 |
| Jenkins Module | 🚧 In Progress | v0.5.0 | 2026-06-10 |
| Monitoring | 🔜 Planned | - | - |
| S3 & IAM | 🔜 Planned | - | - |

### Recent Updates

- ✅ **2026-06-18**: Added production-grade EKS module with complete documentation
- ✅ **2026-06-18**: Created comprehensive IMPLEMENTATION_GUIDE.md
- ✅ **2026-06-18**: Added EKS add-ons configuration (VPC CNI, EBS CSI, CoreDNS)
- ✅ **2026-06-17**: Initial VPC module with multi-AZ support
- 📋 **2026-06-20**: Planning RDS module with backup strategy

---

## 🏛️ Overall Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                        AWS Account                               │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │                       VPC (10.0.0.0/16)                     │ │
│  │                                                             │ │
│  │  ┌─────────────────────────┐  ┌──────────────────────────┐ │ │
│  │  │   Public Subnets        │  │   Private Subnets        │ │ │
│  │  │ (us-east-1a, 1b, 1c)    │  │ (us-east-1a, 1b, 1c)    │ │ │
│  │  │                         │  │                          │ │ │
│  │  │  ┌─────────────────┐    │  │  ┌──────────────────┐    │ │ │
│  │  │  │  ALB / NLB      │    │  │  │   EKS Cluster    │    │ │ │
│  │  │  │  (Ingress)      │    │  │  │  - System Nodes  │    │ │ │
│  │  │  └────────┬────────┘    │  │  │  - App Nodes     │    │ │ │
│  │  │           │              │  │  │  - GPU Nodes*    │    │ │ │
│  │  │  ┌────────▼──────────┐   │  │  └────────┬─────────┘   │ │ │
│  │  │  │   NAT Gateway     │   │  │           │              │ │ │
│  │  │  │  (IGW Route)      │   │  │  ┌────────▼───────────┐  │ │ │
│  │  │  └───────────────────┘   │  │  │   Jenkins CI/CD    │  │ │ │
│  │  └─────────────────────────┘  │  │   (Pipeline Server) │  │ │ │
│  │                               │  └────────────────────┘  │ │ │
│  │  ┌─────────────────────────┐  │  ┌──────────────────────┐ │ │
│  │  │   Internet Gateway      │  │  │    RDS (Multi-AZ)    │ │ │
│  │  │   (0.0.0.0/0)           │  │  │  - Primary: us-east-1a│ │ │
│  │  │                         │  │  │  - Standby: us-east-1b│ │ │
│  │  └─────────────────────────┘  │  └──────────────────────┘ │ │
│  │                               │                            │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │              Monitoring & Logging                           │ │
│  │  • CloudWatch Logs (EKS, RDS, Application)                 │ │
│  │  • CloudWatch Dashboards & Alerts                          │ │
│  │  • AWS X-Ray (Optional)                                    │ │
│  │  • Dynatrace Integration (Optional)                        │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

---

## 📦 Module Features

### 🌐 VPC Module
- Multi-AZ VPC with public and private subnets
- NAT Gateway for private subnet internet access
- Internet Gateway for public internet access
- Network ACLs and Security Groups
- VPC Flow Logs support
- DNS support and hostnames

### ☸️ EKS Module
- **Production-grade EKS cluster** with best practices
- **Multi-AZ deployment** for high availability
- **Multiple node groups**:
  - System node group (3+ nodes)
  - Application node group (scalable)
  - GPU node group (optional, for ML workloads)
- **Security hardening**:
  - KMS encryption for EBS volumes
  - Private API endpoint (public optional)
  - Security groups with least privilege
  - IAM roles with IRSA support
- **Managed add-ons**:
  - VPC CNI for pod networking
  - CoreDNS for service discovery
  - kube-proxy for network routing
  - EBS CSI Driver for persistent volumes
  - EFS CSI Driver (optional)
- **Comprehensive logging**:
  - Control plane logs to CloudWatch
  - Audit logs for compliance
  - Configurable log retention
- **OIDC provider** for IAM roles for service accounts

### 🗄️ RDS Module (In Progress)
- Multi-AZ RDS instances
- MySQL & PostgreSQL support
- Automated backups with configurable retention
- Enhanced monitoring
- Parameter groups and option groups
- Subnet groups for multi-AZ deployment
- Security group management
- Read replicas support

### ⚙️ Jenkins CI/CD Module (In Progress)
- Jenkins EC2 instance deployment
- Pipeline as Code support
- Docker integration
- Blue-Green deployment
- Integration with EKS
- Credential management
- Webhook support for GitHub/GitLab

---

## ⚙️ Prerequisites

### Required Software

- **Terraform** >= 1.0 ([Install](https://developer.hashicorp.com/terraform/install))
- **AWS CLI** >= 2.0 ([Install](https://aws.amazon.com/cli/))
- **kubectl** >= 1.20 ([Install](https://kubernetes.io/docs/tasks/tools/))
- **Helm** >= 3.0 ([Install](https://helm.sh/docs/intro/install/)) - For EKS deployments
- **jq** (Optional, for JSON processing)

### AWS Account Requirements

- ✅ Active AWS account with billing enabled
- ✅ IAM user/role with appropriate permissions
- ✅ VPC with 2-3 private subnets (for EKS)
- ✅ NAT Gateway configured
- ✅ Internet Gateway attached

### System Requirements

- **macOS**: 10.14+
- **Linux**: Ubuntu 20.04 LTS or similar
- **Windows**: WSL2 with Ubuntu 20.04
- **Memory**: 4GB minimum for local testing
- **Disk Space**: 10GB for module files and state

---

## 🚀 Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# Verify you're on master branch
git branch
```

### Step 2: Configure AWS Credentials

```bash
# Method 1: AWS CLI
aws configure
# Enter your Access Key ID, Secret Access Key, region, and output format

# Method 2: Environment Variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"

# Verify credentials
aws sts get-caller-identity
```

### Step 3: Choose a Module

```bash
# View available branches
git branch -r

# Switch to desired module
git checkout feature/eks              # Amazon EKS
# or
git checkout feature/vpc              # AWS VPC
# or
git checkout feature/rds              # AWS RDS
```

### Step 4: Follow Module Guide

Each module branch includes:
- `IMPLEMENTATION_GUIDE.md` - Step-by-step deployment guide
- `examples/` - Configuration examples for different environments
- `modules/` - Reusable Terraform modules
- `README.md` - Module-specific documentation

```bash
# Read the module's implementation guide
cat IMPLEMENTATION_GUIDE.md

# View example configurations
ls -la examples/
```

### Step 5: Deploy

```bash
cd examples/eks              # Navigate to your module's examples

cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your configuration

terraform init              # Initialize Terraform
terraform plan             # Review planned changes
terraform apply            # Deploy infrastructure

# View outputs
terraform output
```

---

## 📁 Directory Structure

```
terraform-aws-infrastructure/
├── README.md                          # This file
├── CONTRIBUTING.md                    # Contribution guidelines
├── CHANGELOG.md                       # Version history
├── LICENSE                            # MIT License
│
├── modules/
│   ├── eks/
│   │   ├── main.tf                    # EKS cluster resources
│   │   ├── node_groups.tf             # Node group configuration
│   │   ├── addons.tf                  # EKS add-ons
│   │   ├── oidc.tf                    # OIDC provider for IRSA
│   │   ├── variables.tf               # Input variables
│   │   ├── outputs.tf                 # Output values
│   │   ├── terraform.tf               # Provider configuration
│   │   └── README.md                  # Module documentation
│   │
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   │
│   ├── rds/
│   │   └── ... (coming soon)
│   │
│   └── jenkins/
│       └── ... (coming soon)
│
├── examples/
│   ├── eks/
│   │   ├── main.tf                    # Example configuration
│   │   ├── variables.tf
│   │   ├── terraform.tfvars.example   # Configuration template
│   │   └── backend.tf.example         # Remote state example
│   │
│   ├── vpc/
│   │   └── ...
│   │
│   └── rds/
│       └── ...
│
└── .gitignore                         # Git ignore rules
```

---

## 🔐 IAM Permissions Required

### Minimum Permissions

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:*",
        "ec2:*",
        "iam:CreateRole",
        "iam:AttachRolePolicy",
        "iam:GetRole",
        "iam:PutRolePolicy",
        "cloudwatch:*",
        "logs:*",
        "kms:*",
        "autoscaling:*",
        "elasticloadbalancing:*"
      ],
      "Resource": "*"
    }
  ]
}
```

### Recommended Managed Policies

Attach these AWS managed policies to your IAM user:
- `AmazonEKSFullAccess`
- `AmazonEC2FullAccess`
- `AWSKeyManagementServicePowerUser`
- `CloudWatchFullAccess`
- `AWSCloudFormationFullAccess`

### ⚠️ Production Recommendations

For production environments:
1. Use **IAM roles instead of access keys** when possible
2. **Scope down permissions** to specific resources
3. Enable **MFA for console access**
4. Use **least privilege principle**
5. Regularly **rotate credentials**
6. Enable **CloudTrail logging**
7. Use **VPC endpoints** for private access

---

## 🏷️ Tagging Strategy

All resources follow a consistent tagging strategy for cost allocation and management:

| Tag | Value | Description | Example |
|-----|-------|-------------|---------|
| `Environment` | dev/staging/prod | Deployment environment | `prod` |
| `Project` | Project name | Project identifier | `myapp` |
| `Module` | Module name | Terraform module name | `eks` |
| `ManagedBy` | Terraform | Infrastructure as Code tool | `Terraform` |
| `Owner` | Team/Person | Responsible team/person | `platform-team` |
| `CostCenter` | Cost center code | For billing allocation | `engineering` |
| `CreatedDate` | YYYY-MM-DD | Creation date | `2026-06-18` |

### Example Resource Tags

```hcl
tags = {
  Environment = "production"
  Project     = "myapp"
  Module      = "eks"
  ManagedBy   = "Terraform"
  Owner       = "platform-team"
  CostCenter  = "engineering"
  CreatedDate = "2026-06-18"
}
```

---

## 💰 Cost Estimates

### EKS Cluster (Example: us-east-1)

| Component | Type | Cost/Month |
|-----------|------|-----------|
| EKS Cluster | Managed | $73.00 |
| System Nodes (3x t3.medium) | EC2 | ~$50.00 |
| Application Nodes (3x t3.large) | EC2 | ~$150.00 |
| NAT Gateway | Data Transfer | ~$32.00 |
| CloudWatch Logs | Storage & Ingestion | ~$10.00 |
| EBS Volumes | Storage | ~$20.00 |
| **Total (Minimum)** | - | **~$335/month** |

### VPC Setup

| Component | Cost/Month |
|-----------|-----------|
| VPC | Free |
| Subnets | Free |
| NAT Gateway | ~$32.00 |
| Data Transfer | ~$10.00 |
| **Total** | **~$42/month** |

### RDS (MySQL, Multi-AZ)

| Component | Cost/Month |
|-----------|-----------|
| db.t3.small (2 instances) | ~$200.00 |
| Storage (100GB) | ~$25.00 |
| Backup Storage | ~$10.00 |
| Data Transfer | ~$5.00 |
| **Total** | **~$240/month** |

**Note**: Costs are estimates and vary by region and usage.

---

## 📖 Documentation

### Main Documentation
- [README.md](./README.md) - This file
- [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md) - Step-by-step deployment (in each branch)
- [CONTRIBUTING.md](./CONTRIBUTING.md) - How to contribute
- [CHANGELOG.md](./CHANGELOG.md) - Version history and updates

### Module Documentation
Each branch contains:
- `modules/<name>/README.md` - Module-specific documentation
- `examples/<name>/` - Working configuration examples
- Inline comments in `.tf` files

### External Resources
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [AWS Best Practices](https://aws.amazon.com/architecture/well-architected/)

---

## 🤝 Contributing

We welcome contributions! Here's how to help:

### Before You Start
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Read [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines

### Development Process

```bash
# 1. Make your changes
# 2. Test locally
terraform validate
terraform fmt -check -recursive .

# 3. Commit with meaningful messages
git commit -m "feat: Add new feature"
git commit -m "fix: Resolve issue #123"
git commit -m "docs: Update README"

# 4. Push to your fork
git push origin feature/my-feature

# 5. Create Pull Request
# - Reference any related issues
# - Describe changes clearly
# - Add tests if applicable
```

### Commit Message Convention

```
<type>: <subject>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Example:
```
feat: Add EKS GPU node group support

Enables deployment of GPU nodes for ML workloads
with automatic driver installation via add-ons.

Closes #42
```

---

## 🎯 Best Practices

### Terraform

- ✅ Use `terraform fmt` to format code
- ✅ Use `terraform validate` before pushing
- ✅ Add descriptions to variables and outputs
- ✅ Use `terraform plan` before `apply`
- ✅ Store state in remote backend (S3 + DynamoDB)
- ✅ Use variable validation rules
- ✅ Document complex logic in comments

### AWS

- ✅ Use multi-AZ deployments for HA
- ✅ Enable encryption at rest and in transit
- ✅ Implement least privilege IAM
- ✅ Use security groups as virtual firewalls
- ✅ Enable CloudTrail logging
- ✅ Use VPC private subnets for compute
- ✅ Implement tagging for cost tracking
- ✅ Regular backups and disaster recovery testing

### Infrastructure

- ✅ Version your modules and releases
- ✅ Document all manual steps
- ✅ Automate everything possible
- ✅ Test in dev/staging before prod
- ✅ Monitor logs and metrics
- ✅ Have a disaster recovery plan
- ✅ Review security regularly
- ✅ Keep software updated

---

## 🆘 Support

### Getting Help

1. **Check Documentation**
   - Read [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md)
   - Review module's README.md
   - Check inline code comments

2. **Troubleshooting**
   - Enable debug logging: `TF_LOG=DEBUG terraform plan`
   - Check CloudWatch logs
   - Review Terraform state: `terraform state list`

3. **Report Issues**
   - Search existing [GitHub Issues](https://github.com/sujithp28/terraform-aws-infrastructure/issues)
   - Create detailed bug report with:
     - Terraform version
     - AWS region
     - Error message (full stack trace)
     - Steps to reproduce

4. **Ask Questions**
   - Create [GitHub Discussion](https://github.com/sujithp28/terraform-aws-infrastructure/discussions)
   - Include context and what you've already tried

### Issue Template

```
## Description
Brief description of the issue

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Steps to Reproduce
1. Step 1
2. Step 2

## Environment
- Terraform: vX.X.X
- AWS Region: us-east-1
- Module: eks

## Additional Context
Error logs, screenshots, etc.
```

---

## 📝 Changelog

See [CHANGELOG.md](./CHANGELOG.md) for detailed version history.

### Latest Release: v1.0.0
- ✅ EKS module production-ready
- ✅ VPC module with multi-AZ support
- ✅ Complete documentation and examples
- ✅ Security best practices implemented

---

## 👤 Author

**Sujith** — Senior DevOps Engineer  
Passionate about Infrastructure as Code, Kubernetes, and AWS

### Connect

[![GitHub](https://img.shields.io/badge/GitHub-sujithp28-black?style=flat&logo=github)](https://github.com/sujithp28)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Sujith%20P-blue?style=flat&logo=linkedin)](https://linkedin.com/in/sujithp)
[![Email](https://img.shields.io/badge/Email-Contact-red?style=flat&logo=gmail)](mailto:sujith@example.com)

---

## 📄 License

This project is licensed under the **MIT License** - see [LICENSE](./LICENSE) file for details.

---

## 🙏 Acknowledgments

- AWS for comprehensive documentation and services
- Terraform community for best practices
- Kubernetes community for standards and tools
- Contributors and users providing feedback

---

## 📞 Contact & Support

- **Issues**: [GitHub Issues](https://github.com/sujithp28/terraform-aws-infrastructure/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sujithp28/terraform-aws-infrastructure/discussions)
- **Email**: sujith@example.com
- **LinkedIn**: [Connect here](https://linkedin.com/in/sujithp)

---

**⭐ If you find this project helpful, please give it a star!**

---

**Last Updated**: 2026-06-18  
**Terraform Version**: >= 1.0  
**AWS Provider**: >= 5.0
