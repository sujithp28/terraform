provider "aws" {
  region = var.aws_region
}

module "jenkins" {
  source = "../../modules/jenkins"

  name                = "${var.project}-jenkins"
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  instance_type       = var.instance_type
  volume_size         = var.volume_size
  key_name            = var.key_name
  allowed_cidr_blocks = var.allowed_cidr_blocks
  eks_cluster_name    = var.eks_cluster_name
  aws_region          = var.aws_region

  tags = {
    Environment = var.environment
    Project     = var.project
    Module      = "jenkins"
    ManagedBy   = "Terraform"
    Owner       = var.owner
  }
}
