# Changelog

All notable changes are documented here following [Keep a Changelog](https://keepachangelog.com/).

## [1.2.0] - 2026-06-24

### Added
- Master README overhaul: security best practices, troubleshooting, roadmap
- `feature/vpc` branch: production VPC module (multi-AZ, NAT, flow logs)
- `feature/jenkins-cicd` branch: Jenkins EC2 module + Jenkinsfile pipeline
- `feature/monitoring` branch: CloudWatch alarms, SNS, dashboard module
- `feature/s3-iam` branch: S3 bucket with encryption/versioning + dynamic IAM roles
- `.gitignore`, `CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE` on master

## [1.1.0] - 2026-06-23

### Added
- RDS module production-ready (MySQL 8.0 & PostgreSQL 15)
- Multi-AZ support, read replicas, storage autoscaling
- CloudWatch alarms: CPU, free storage, free memory, connections
- Complete RDS examples and `IMPLEMENTATION_GUIDE.md`

## [1.0.0] - 2026-06-18

### Added
- EKS module: cluster, node groups (system/app/GPU), OIDC/IRSA
- EKS managed add-ons: VPC CNI, EBS CSI, EFS CSI, CoreDNS
- VPC module: multi-AZ subnets, IGW, NAT Gateway, route tables
- Comprehensive `IMPLEMENTATION_GUIDE.md` for each module
- Security hardening: KMS encryption, private endpoints, least-privilege IAM
