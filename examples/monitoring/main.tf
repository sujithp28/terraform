provider "aws" {
  region = var.aws_region
}

module "monitoring" {
  source = "../../modules/monitoring"

  name             = "${var.project}-${var.environment}"
  alarm_email      = var.alarm_email
  eks_cluster_name = var.eks_cluster_name
  rds_instance_id  = var.rds_instance_id

  tags = {
    Environment = var.environment
    Project     = var.project
    Module      = "monitoring"
    ManagedBy   = "Terraform"
  }
}
