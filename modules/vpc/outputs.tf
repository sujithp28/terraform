# -------------------------------------------------------
# AWS VPC Module - outputs.tf
# -------------------------------------------------------

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.this[*].id
}

output "bastion_sg_id" {
  description = "Security Group ID for bastion host"
  value       = aws_security_group.bastion.id
}

output "alb_sg_id" {
  description = "Security Group ID for Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "app_sg_id" {
  description = "Security Group ID for application servers / EKS worker nodes"
  value       = aws_security_group.app.id
}

output "rds_sg_id" {
  description = "Security Group ID for RDS database"
  value       = aws_security_group.rds.id
}
