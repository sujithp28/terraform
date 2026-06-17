# -------------------------------------------------------
# Prod Environment - outputs.tf
# -------------------------------------------------------

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = module.vpc.nat_gateway_ids
}

output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = module.vpc.alb_sg_id
}

output "app_sg_id" {
  description = "App Security Group ID"
  value       = module.vpc.app_sg_id
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = module.vpc.rds_sg_id
}
