# Monitoring Module — Implementation Guide

## Overview
This module provisions:
- SNS Topic + Email subscription for alarm notifications
- CloudWatch Alarms: RDS CPU, free storage, connection count
- CloudWatch Dashboard with all key metrics in one view
- CloudWatch Log Group for application logs

## Quick Deploy

```bash
cd examples/monitoring
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars    # Set alarm_email, rds_instance_id, eks_cluster_name
terraform init
terraform plan
terraform apply
```

## After Deploy
1. Check your email and **confirm the SNS subscription** to receive alerts
2. Open the Dashboard URL from `terraform output dashboard_url`

## Extending Alarms
Add more `aws_cloudwatch_metric_alarm` blocks in `modules/monitoring/main.tf`.
All alarms route to the same SNS topic.

## Destroy
```bash
terraform destroy
```
