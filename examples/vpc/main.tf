provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway
  enable_flow_logs    = var.enable_flow_logs

  tags = {
    Environment = var.environment
    Project     = var.project
    Module      = "vpc"
    ManagedBy   = "Terraform"
    Owner       = var.owner
  }
}
