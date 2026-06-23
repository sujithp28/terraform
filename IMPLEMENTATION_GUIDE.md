# Jenkins CI/CD Module — Implementation Guide

## Overview
Deploys a Jenkins LTS server on an EC2 instance in a private subnet with:
- Java 17 + Jenkins LTS
- Docker daemon for container builds
- AWS CLI + kubectl + Helm pre-installed
- IAM role with ECR, EKS, S3, Secrets Manager access
- IMDSv2 enforced (security hardened)
- Jenkinsfile for full Docker build → ECR push → EKS deploy pipeline

## Prerequisites
- VPC with private subnet (deploy VPC module first)
- Terraform >= 1.0
- AWS credentials configured

## Quick Deploy

```bash
cd examples/jenkins
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars    # Set vpc_id, subnet_id, eks_cluster_name
terraform init
terraform plan
terraform apply
```

## Access Jenkins

Jenkins runs on port 8080 on the private IP. Access via:
1. **SSM Session Manager** (recommended — no SSH key needed):
   ```bash
   aws ssm start-session --target <instance-id>
   ```
2. **SSH** (if key_name is set):
   ```bash
   ssh -i my-keypair.pem ec2-user@<private-ip>
   ```

## Initial Jenkins Password
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

## Recommended Jenkins Plugins
- Pipeline
- Git
- Docker Pipeline
- Amazon ECR
- Kubernetes CLI
- AWS Credentials
- Blue Ocean (UI)
- Slack Notification

## Using the Jenkinsfile
1. Store the `Jenkinsfile` at the root of your application repo
2. Create a Jenkins Pipeline job pointing to your repo
3. Set credentials:
   - `ECR_REGISTRY` — your ECR registry URL
4. Trigger via git push or webhook

## Destroy
```bash
terraform destroy
```
