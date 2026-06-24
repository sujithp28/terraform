# 🗄️ RDS Module

Production-grade AWS RDS with Multi-AZ, read replicas, encryption, Enhanced Monitoring, and CloudWatch alarms.

## Features
- MySQL 8.0 and PostgreSQL 15 support
- Multi-AZ deployment with automatic failover
- Optional read replica with configurable instance class
- Storage autoscaling with configurable max threshold
- KMS encryption at rest (AWS-managed or CMK)
- Enhanced Monitoring (per-process metrics, 1–60s granularity)
- Performance Insights with query-level analysis
- CloudWatch Alarms: CPU, free storage, free memory, connections
- Custom parameter groups (engine-specific tuning)
- Option groups for MySQL advanced features
- Security groups with CIDR + SG-based ingress

## Quick Start
```bash
git checkout feature/rds
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars
terraform init && terraform plan && terraform apply
```

See `IMPLEMENTATION_GUIDE.md` for full details.
