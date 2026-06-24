# See root variables.tf — this file re-exports the same variables
# for the modules/rds/ path so both flat and module-based usage work.

variable "identifier" { description = "Unique identifier for the RDS instance"; type = string }
variable "environment" { description = "Deployment environment"; type = string; validation { condition = contains(["dev","staging","prod"], var.environment); error_message = "Must be dev, staging, or prod." } }
variable "project"     { description = "Project name"; type = string }
variable "engine"      { description = "Database engine: mysql or postgres"; type = string; default = "mysql" }
variable "engine_version" { description = "Engine version"; type = string; default = null }
variable "instance_class" { description = "RDS instance class"; type = string; default = "db.t3.small" }
variable "allocated_storage" { description = "Initial storage GB"; type = number; default = 20 }
variable "max_allocated_storage" { description = "Max storage GB for autoscaling"; type = number; default = 100 }
variable "storage_type" { description = "gp2, gp3, or io1"; type = string; default = "gp3" }
variable "iops" { description = "IOPS for io1"; type = number; default = null }
variable "storage_encrypted" { description = "Encrypt storage"; type = bool; default = true }
variable "kms_key_id" { description = "KMS key ARN"; type = string; default = null }
variable "db_name"        { description = "Initial database name"; type = string }
variable "master_username" { description = "Master username"; type = string; sensitive = true }
variable "master_password" { description = "Master password"; type = string; sensitive = true }
variable "vpc_id"          { description = "VPC ID"; type = string }
variable "subnet_ids"      { description = "Private subnet IDs"; type = list(string) }
variable "allowed_cidr_blocks" { description = "CIDRs allowed to connect"; type = list(string); default = [] }
variable "allowed_security_group_ids" { description = "SG IDs allowed to connect"; type = list(string); default = [] }
variable "publicly_accessible" { description = "Public accessibility"; type = bool; default = false }
variable "multi_az" { description = "Enable Multi-AZ"; type = bool; default = true }
variable "create_read_replica" { description = "Create read replica"; type = bool; default = false }
variable "read_replica_instance_class" { description = "Replica instance class"; type = string; default = null }
variable "backup_retention_period" { description = "Backup retention days"; type = number; default = 7 }
variable "backup_window" { description = "Backup window UTC"; type = string; default = "03:00-04:00" }
variable "maintenance_window" { description = "Maintenance window"; type = string; default = "Mon:04:00-Mon:05:00" }
variable "skip_final_snapshot" { description = "Skip final snapshot"; type = bool; default = false }
variable "final_snapshot_identifier" { description = "Final snapshot name"; type = string; default = null }
variable "delete_automated_backups" { description = "Delete automated backups on termination"; type = bool; default = true }
variable "copy_tags_to_snapshot" { description = "Copy tags to snapshots"; type = bool; default = true }
variable "monitoring_interval" { description = "Enhanced monitoring interval (0=disabled)"; type = number; default = 60 }
variable "performance_insights_enabled" { description = "Enable Performance Insights"; type = bool; default = true }
variable "performance_insights_retention_period" { description = "PI retention days"; type = number; default = 7 }
variable "enabled_cloudwatch_logs_exports" { description = "CW log types to export"; type = list(string); default = null }
variable "parameter_group_family" { description = "Parameter group family"; type = string; default = null }
variable "parameters" { description = "Parameter group parameters"; type = list(object({ name = string; value = string; apply_method = optional(string, "immediate") })); default = [] }
variable "options" { description = "Option group options (MySQL)"; type = list(object({ option_name = string; option_settings = optional(list(object({ name = string; value = string })), []) })); default = [] }
variable "auto_minor_version_upgrade" { description = "Allow minor version upgrades"; type = bool; default = true }
variable "deletion_protection" { description = "Enable deletion protection"; type = bool; default = false }
variable "apply_immediately" { description = "Apply changes immediately"; type = bool; default = false }
variable "tags" { description = "Additional tags"; type = map(string); default = {} }
