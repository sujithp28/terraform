output "db_endpoint" {
  description = "Database endpoint to use in application config"
  value       = module.rds.db_instance_endpoint
}

output "db_address" {
  description = "Database hostname"
  value       = module.rds.db_instance_address
}

output "db_port" {
  description = "Database port"
  value       = module.rds.db_instance_port
}

output "db_name" {
  description = "Database name"
  value       = module.rds.db_name
}

output "db_username" {
  description = "Master username"
  value       = module.rds.db_username
  sensitive   = true
}

output "security_group_id" {
  description = "RDS security group ID"
  value       = module.rds.security_group_id
}

output "db_replica_endpoint" {
  description = "Read replica endpoint (if created)"
  value       = module.rds.db_replica_endpoint
}

output "connection_string" {
  description = "CLI connection string (password not included)"
  value = coalesce(
    module.rds.connection_string_mysql,
    module.rds.connection_string_psql
  )
}
