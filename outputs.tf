# ============================================================
# RDS Module - Outputs
# ============================================================

# ----------------------------
# Primary Instance
# ----------------------------

output "db_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.primary.id
}

output "db_instance_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.primary.arn
}

output "db_instance_endpoint" {
  description = "Connection endpoint (host:port)"
  value       = aws_db_instance.primary.endpoint
}

output "db_instance_address" {
  description = "Hostname of the RDS instance"
  value       = aws_db_instance.primary.address
}

output "db_instance_port" {
  description = "Port the database is listening on"
  value       = aws_db_instance.primary.port
}

output "db_name" {
  description = "Name of the default database"
  value       = aws_db_instance.primary.db_name
}

output "db_username" {
  description = "Master username"
  value       = aws_db_instance.primary.username
  sensitive   = true
}

output "db_engine" {
  description = "Database engine"
  value       = aws_db_instance.primary.engine
}

output "db_engine_version" {
  description = "Database engine version"
  value       = aws_db_instance.primary.engine_version_actual
}

output "db_instance_class" {
  description = "Instance class"
  value       = aws_db_instance.primary.instance_class
}

output "db_availability_zone" {
  description = "Availability zone of the primary instance"
  value       = aws_db_instance.primary.availability_zone
}

output "db_multi_az" {
  description = "Whether Multi-AZ is enabled"
  value       = aws_db_instance.primary.multi_az
}

output "db_storage_encrypted" {
  description = "Whether storage encryption is enabled"
  value       = aws_db_instance.primary.storage_encrypted
}

output "db_hosted_zone_id" {
  description = "Hosted zone ID for the RDS endpoint"
  value       = aws_db_instance.primary.hosted_zone_id
}

output "db_resource_id" {
  description = "Resource ID of the RDS instance (for IAM auth)"
  value       = aws_db_instance.primary.resource_id
}

# ----------------------------
# Read Replica
# ----------------------------

output "db_replica_endpoint" {
  description = "Endpoint for the read replica (empty if not created)"
  value       = var.create_read_replica ? aws_db_instance.replica[0].endpoint : null
}

output "db_replica_address" {
  description = "Hostname of the read replica (empty if not created)"
  value       = var.create_read_replica ? aws_db_instance.replica[0].address : null
}

# ----------------------------
# Networking
# ----------------------------

output "security_group_id" {
  description = "Security group ID attached to the RDS instance"
  value       = aws_security_group.rds.id
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.this.name
}

output "db_subnet_group_arn" {
  description = "ARN of the DB subnet group"
  value       = aws_db_subnet_group.this.arn
}

# ----------------------------
# Parameter & Option Groups
# ----------------------------

output "db_parameter_group_name" {
  description = "Name of the parameter group"
  value       = aws_db_parameter_group.this.name
}

output "db_option_group_name" {
  description = "Name of the option group (MySQL only)"
  value       = var.engine == "mysql" ? aws_db_option_group.this[0].name : null
}

# ----------------------------
# Monitoring
# ----------------------------

output "monitoring_role_arn" {
  description = "ARN of the enhanced monitoring IAM role"
  value       = var.monitoring_interval > 0 ? aws_iam_role.rds_monitoring[0].arn : null
}

output "cloudwatch_alarm_cpu_arn" {
  description = "ARN of the CPU utilization CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_high.arn
}

output "cloudwatch_alarm_storage_arn" {
  description = "ARN of the free storage CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.free_storage_low.arn
}

# ----------------------------
# Connection String Helpers
# ----------------------------

output "connection_string_mysql" {
  description = "MySQL connection string (password omitted)"
  value = var.engine == "mysql" ? format(
    "mysql -h %s -P %s -u %s -p %s",
    aws_db_instance.primary.address,
    aws_db_instance.primary.port,
    aws_db_instance.primary.username,
    aws_db_instance.primary.db_name
  ) : null
}

output "connection_string_psql" {
  description = "PostgreSQL connection string (password omitted)"
  value = var.engine == "postgres" ? format(
    "psql -h %s -p %s -U %s -d %s",
    aws_db_instance.primary.address,
    aws_db_instance.primary.port,
    aws_db_instance.primary.username,
    aws_db_instance.primary.db_name
  ) : null
}
