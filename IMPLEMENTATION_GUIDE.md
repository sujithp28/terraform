# S3 & IAM Module — Implementation Guide

## Overview
This module creates:
- S3 bucket with versioning, AES-256 encryption, public access block, HTTPS-only policy
- Lifecycle rules: objects transition to Glacier after 90 days, expire after 365 days
- Optional cross-region replication with dedicated IAM replication role
- Dynamic IAM roles attached to configurable AWS managed policies

## Quick Deploy

```bash
cd examples/s3-iam
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars    # Set bucket_name (globally unique), iam_roles
terraform init
terraform plan
terraform apply
```

## Notes
- S3 bucket names are **globally unique** — include your account ID or project ID
- HTTPS is enforced via bucket policy (all HTTP requests are denied)
- To enable replication, set `enable_replication = true` and provide `replication_destination_bucket_arn`

## Destroy
```bash
terraform destroy
# Note: S3 bucket must be empty before destroy
# Empty the bucket first:
aws s3 rm s3://your-bucket-name --recursive
```
