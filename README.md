# 📊 Monitoring Module

CloudWatch dashboards, metric alarms, and SNS email alerts for your AWS infrastructure.

## Features
- SNS topic with email subscription for alarm notifications
- CloudWatch Alarms: RDS CPU, free storage, connection count
- CloudWatch Dashboard with all key metrics in one view
- Application CloudWatch Log Group
- Easily extended with more alarm resources

## Quick Start
```bash
cd examples/monitoring
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars      # Set alarm_email, rds_instance_id
terraform init && terraform plan && terraform apply
```

> After apply: check your email and **confirm the SNS subscription**.

See `IMPLEMENTATION_GUIDE.md` for full details.
