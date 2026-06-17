# 🏗 Terraform AWS Infrastructure

> Production-grade, modular AWS infrastructure built with Terraform.  
> Each module is maintained in its own branch and independently deployable.

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)

---

## 📌 Branch Strategy

Each infrastructure module lives in its own branch.  
The `main` branch contains this overview only.

| Branch | Module | Description | Status |
|---|---|---|---|
| [`https://github.com/sujithp28/terraform.git`](#) | 🌐 AWS VPC | VPC, Subnets, IGW, NAT, Security Groups | ✅ Ready |
| [`feature/eks`](#) | ☸️ Amazon EKS | EKS Cluster, Node Groups, IAM Roles | 🚧 In Progress |
| [`feature/jenkins-cicd`](#) | ⚙️ Jenkins CI/CD | Jenkins on EC2, Pipeline as Code | 🚧 In Progress |
| [`feature/monitoring`](#) | 📊 Monitoring | Dynatrace + CloudWatch Dashboards & Alerts | 🔜 Planned |
| [`feature/rds`](#) | 🗄 AWS RDS | RDS MySQL/PostgreSQL with Multi-AZ | 🔜 Planned |
| [`feature/s3-iam`](#) | 🔐 S3 & IAM | S3 Buckets, IAM Roles, Policies | 🔜 Planned |

> Replace `#` links above with actual branch URLs after pushing to GitHub.

---

## 🏛 Overall Architecture

```
                          ┌─────────────────────────────────┐
                          │         AWS Account              │
                          │                                  │
                          │   ┌──────────────────────────┐  │
                          │   │         VPC               │  │
                          │   │  ┌─────────┐ ┌─────────┐ │  │
                          │   │  │ Public  │ │ Private │ │  │
                          │   │  │ Subnets │ │ Subnets │ │  │
                          │   │  └────┬────┘ └────┬────┘ │  │
                          │   │       │            │      │  │
                          │   │  ┌────▼────┐  ┌───▼───┐  │  │
                          │   │  │   ALB   │  │  EKS  │  │  │
                          │   │  └────┬────┘  └───┬───┘  │  │
                          │   │       │            │      │  │
                          │   │  ┌────▼────────────▼───┐  │  │
                          │   │  │       Jenkins        │  │  │
                          │   │  │    CI/CD Pipeline    │  │  │
                          │   │  └─────────────────────┘  │  │
                          │   └──────────────────────────┘  │
                          └─────────────────────────────────┘
```

---

## 🌿 How to Use a Module

Each branch is a standalone, deployable Terraform module.

```bash
# 1. Clone the repo
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# 2. Switch to the module branch you want
git checkout feature/vpc

# 3. Go to the environment you want to deploy
cd environments/dev        # or staging / prod

# 4. Initialize and deploy
terraform init
terraform plan
terraform apply
```

---

## 📁 Standard Module Structure

Every branch follows this consistent structure:

```
├── modules/
│   └── <module-name>/
│       ├── main.tf          # Core resources
│       ├── variables.tf     # Input variables with validation
│       └── outputs.tf       # Output values
├── environments/
│   ├── dev/
│   │   ├── main.tf          # Dev-specific config
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── staging/
│   └── prod/
├── .gitignore
└── README.md                # Module-specific documentation
```

---

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with IAM credentials
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (for EKS branch)
- [Helm](https://helm.sh/docs/intro/install/) (for EKS branch)

---

## 🔐 AWS IAM Permissions Required

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "eks:*",
        "iam:*",
        "s3:*",
        "rds:*",
        "elasticloadbalancing:*",
        "cloudwatch:*",
        "logs:*",
        "autoscaling:*"
      ],
      "Resource": "*"
    }
  ]
}
```

> ⚠️ For production, scope down permissions to specific resources.

---

## 🏷 Tagging Strategy

All resources follow a consistent tagging strategy:

| Tag | Value | Description |
|---|---|---|
| `Project` | `myapp` | Project name |
| `Environment` | `dev / staging / prod` | Deployment environment |
| `ManagedBy` | `Terraform` | IaC tool |
| `Owner` | `DevOps` | Responsible team |

---

## 👤 Author

**Sujith** — Senior DevOps Engineer

[![GitHub](https://img.shields.io/badge/GitHub-sujithp28-black?style=flat&logo=github)](https://github.com/sujithp28)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://linkedin.com/in/YOUR_LINKEDIN)
