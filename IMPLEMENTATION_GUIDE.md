# RDS Module — Implementation Guide

## Overview
This module creates a production-grade AWS RDS instance with:
- Multi-engine: MySQL 8.0 or PostgreSQL 15
- Multi-AZ with automatic failover
- Optional read replica
- Storage autoscaling
- KMS encryption at rest
- Enhanced Monitoring + Performance Insights
- CloudWatch Alarms: CPU, free storage, free memory, connections
- Custom parameter groups (MySQL & PostgreSQL)
- Option groups (MySQL)

## Prerequisites
- VPC with 2+ private subnets in different AZs
- Terraform >= 1.0, AWS CLI >= 2.0

## Quick Deploy

```bash
git checkout feature/rds
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars   # Set vpc_id, subnet_ids, master_password
terraform init
terraform plan
terraform apply
```

## Key Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `engine` | `mysql` | `mysql` or `postgres` |
| `instance_class` | `db.t3.small` | Instance type |
| `multi_az` | `true` | Enable Multi-AZ |
| `create_read_replica` | `false` | Add read replica |
| `deletion_protection` | `false` | Set `true` in prod |
| `skip_final_snapshot` | `false` | Set `true` only in dev |

## Environments

Pre-configured tfvars live in `environments/`:
- `environments/dev/` — small instance, single-AZ, short retention
- `environments/prod/` — multi-AZ, deletion protection, longer retention

## Connect to Database

```bash
# MySQL
mysql -h $(terraform output -raw db_instance_address) \
      -P $(terraform output -raw db_instance_port) \
      -u $(terraform output -raw db_username) -p mydb

# PostgreSQL
psql -h $(terraform output -raw db_instance_address) \
     -p $(terraform output -raw db_instance_port) \
     -U $(terraform output -raw db_username) mydb
```

## Destroy
```bash
# Disable deletion protection first if enabled
terraform apply -var='deletion_protection=false'
terraform destroy
```
