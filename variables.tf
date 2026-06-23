# ============================================================
# RDS Module - Variables
# ============================================================

# ----------------------------
# General
# ----------------------------

variable "identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "project" {
  description = "Project name for tagging and naming"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# ----------------------------
# Engine
# ----------------------------

variable "engine" {
  description = "Database engine: mysql or postgres"
  type        = string
  default     = "mysql"
  validation {
    condition     = contains(["mysql", "postgres"], var.engine)
    error_message = "Engine must be either 'mysql' or 'postgres'."
  }
}

variable "engine_version" {
  description = "Engine version. Defaults based on engine if not set."
  type        = string
  default     = null
}

variable "instance_class" {
  description = "RDS instance class (e.g. db.t3.small, db.r6g.large)"
  type        = string
  default     = "db.t3.small"
}

# ----------------------------
# Storage
# ----------------------------

variable "allocated_storage" {
  description = "Initial storage in GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Max storage for autoscaling in GB (set to 0 to disable)"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type: gp2, gp3, io1"
  type        = string
  default     = "gp3"
}

variable "iops" {
  description = "IOPS for io1 storage type (ignored for gp2/gp3)"
  type        = number
  default     = null
}

# ----------------------------
# Database Credentials
# ----------------------------

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "master_username" {
  description = "Master username for the database"
  type        = string
  sensitive   = true
}

variable "master_password" {
  description = "Master password for the database (use Secrets Manager in prod)"
  type        = string
  sensitive   = true
}

# ----------------------------
# Networking
# ----------------------------

variable "vpc_id" {
  description = "VPC ID to deploy the RDS instance in"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for the DB subnet group (min 2 for Multi-AZ)"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to the DB port"
  type        = list(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security group IDs allowed to connect to the DB"
  type        = list(string)
  default     = []
}

variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible"
  type        = bool
  default     = false
}

# ----------------------------
# High Availability
# ----------------------------

variable "multi_az" {
  description = "Enable Multi-AZ for high availability"
  type        = bool
  default     = true
}

variable "create_read_replica" {
  description = "Whether to create a read replica"
  type        = bool
  default     = false
}

variable "read_replica_instance_class" {
  description = "Instance class for the read replica (defaults to primary)"
  type        = string
  default     = null
}

# ----------------------------
# Backup & Maintenance
# ----------------------------

variable "backup_retention_period" {
  description = "Number of days to retain automated backups (0 = disabled)"
  type        = number
  default     = 7
  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "Backup retention must be between 0 and 35 days."
  }
}

variable "backup_window" {
  description = "Daily backup window (UTC) e.g. '03:00-04:00'"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Weekly maintenance window e.g. 'Mon:04:00-Mon:05:00'"
  type        = string
  default     = "Mon:04:00-Mon:05:00"
}

variable "delete_automated_backups" {
  description = "Delete automated backups when the instance is deleted"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Copy all instance tags to snapshots"
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "Name of the final snapshot on deletion. Set to null to skip."
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion (not recommended for prod)"
  type        = bool
  default     = false
}

# ----------------------------
# Encryption
# ----------------------------

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "ARN of KMS key for encryption (uses AWS default if null)"
  type        = string
  default     = null
}

# ----------------------------
# Monitoring
# ----------------------------

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds (0 = disabled)"
  type        = number
  default     = 60
  validation {
    condition     = contains([0, 1, 5, 10, 15, 30, 60], var.monitoring_interval)
    error_message = "Monitoring interval must be one of: 0, 1, 5, 10, 15, 30, 60."
  }
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention in days (7 = free tier, 731 = paid)"
  type        = number
  default     = 7
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Log types to export to CloudWatch. Defaults per engine."
  type        = list(string)
  default     = null
}

# ----------------------------
# Parameter Group
# ----------------------------

variable "parameter_group_family" {
  description = "DB parameter group family (e.g. mysql8.0, postgres15). Auto-derived if null."
  type        = string
  default     = null
}

variable "parameters" {
  description = "List of DB parameter group parameters to set"
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "immediate")
  }))
  default = []
}

# ----------------------------
# Options (MySQL only)
# ----------------------------

variable "options" {
  description = "List of option group options (MySQL only)"
  type = list(object({
    option_name = string
    option_settings = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
  default = []
}

# ----------------------------
# Misc
# ----------------------------

variable "auto_minor_version_upgrade" {
  description = "Allow automatic minor version upgrades"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Enable deletion protection (recommended for prod)"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply changes immediately instead of during maintenance window"
  type        = bool
  default     = false
}
