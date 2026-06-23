# ============================================================
# Example: RDS Module Deployment
# ============================================================
#
# This example deploys an RDS instance using the rds module.
# It expects an existing VPC and private subnets (from feature/vpc).
#
# Usage:
#   cp terraform.tfvars.example terraform.tfvars
#   terraform init && terraform plan && terraform apply

provider "aws" {
  region = var.aws_region
}

# ----------------------------
# Fetch VPC & Subnets (if using feature/vpc module outputs)
# Remove this data block if you supply IDs directly in tfvars.
# ----------------------------

# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket = "your-terraform-state-bucket"
#     key    = "vpc/terraform.tfstate"
#     region = var.aws_region
#   }
# }

# ----------------------------
# RDS Module
# ----------------------------

module "rds" {
  source = "../../modules/rds"

  # Identity
  identifier  = var.db_identifier
  environment = var.environment
  project     = var.project

  # Engine
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  # Storage
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type

  # Credentials
  db_name         = var.db_name
  master_username = var.master_username
  master_password = var.master_password

  # Networking
  vpc_id                     = var.vpc_id
  subnet_ids                 = var.private_subnet_ids
  allowed_cidr_blocks        = var.allowed_cidr_blocks
  allowed_security_group_ids = var.allowed_security_group_ids

  # HA
  multi_az            = var.multi_az
  create_read_replica = var.create_read_replica

  # Backup
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window
  maintenance_window        = var.maintenance_window
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  # Security
  storage_encrypted = var.storage_encrypted
  deletion_protection = var.deletion_protection

  # Monitoring
  monitoring_interval          = var.monitoring_interval
  performance_insights_enabled = var.performance_insights_enabled

  # Parameters
  parameters = var.parameters

  tags = var.tags
}
