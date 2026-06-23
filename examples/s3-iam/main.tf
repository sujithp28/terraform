provider "aws" {
  region = var.aws_region
}

module "s3_iam" {
  source = "../../modules/s3-iam"

  bucket_name        = var.bucket_name
  environment        = var.environment
  enable_versioning  = var.enable_versioning
  enable_replication = var.enable_replication

  iam_roles = var.iam_roles

  tags = {
    Environment = var.environment
    Project     = var.project
    Module      = "s3-iam"
    ManagedBy   = "Terraform"
    Owner       = var.owner
  }
}
