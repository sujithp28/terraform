# ⚙️ Jenkins CI/CD Module

Jenkins LTS on EC2 with Docker, kubectl, Helm, and full EKS pipeline integration.

## Features
- Amazon Linux 2023 EC2 with Java 17 + Jenkins LTS
- Docker daemon for container image builds
- AWS CLI v2, kubectl, Helm pre-installed via userdata
- IAM role: ECR push, EKS describe, S3, Secrets Manager
- IMDSv2 enforced (security hardened)
- Jenkinsfile: build → Trivy scan → ECR push → EKS rolling deploy

## Quick Start
```bash
cd examples/jenkins
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars      # Set vpc_id, subnet_id
terraform init && terraform plan && terraform apply
```

### Get Initial Admin Password
```bash
aws ssm start-session --target $(terraform output -raw instance_id)
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

See `IMPLEMENTATION_GUIDE.md` for full details.
