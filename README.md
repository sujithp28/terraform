# 🔐 S3 & IAM Module

Secure S3 bucket with encryption, versioning, lifecycle rules, optional replication, and dynamic IAM roles.

## Features
- S3 bucket: AES-256 encryption, public access block, HTTPS-only bucket policy
- Versioning with noncurrent version expiry
- Lifecycle: Glacier transition (90 days) + object expiry (365 days)
- Optional cross-region replication with dedicated IAM replication role
- Dynamic IAM roles: configure any number of roles + managed policy attachments via a single variable

## Quick Start
```bash
cd examples/s3-iam
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars      # Set globally-unique bucket_name, iam_roles
terraform init && terraform plan && terraform apply
```

> **Note**: Empty the bucket before `terraform destroy`:
> `aws s3 rm s3://your-bucket --recursive`

See `IMPLEMENTATION_GUIDE.md` for full details.
