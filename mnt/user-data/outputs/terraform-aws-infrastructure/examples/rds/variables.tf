variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "project" {
  type    = string
  default = "myapp"
}

variable "db_identifier" {
  type    = string
  default = "myapp-db"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = null
}

variable "instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "db_name" {
  type = string
}

variable "master_username" {
  type      = string
  sensitive = true
}

variable "master_password" {
  type      = string
  sensitive = true
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "allowed_security_group_ids" {
  type    = list(string)
  default = []
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "create_read_replica" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "backup_window" {
  type    = string
  default = "03:00-04:00"
}

variable "maintenance_window" {
  type    = string
  default = "Mon:04:00-Mon:05:00"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "final_snapshot_identifier" {
  type    = string
  default = null
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "monitoring_interval" {
  type    = number
  default = 60
}

variable "performance_insights_enabled" {
  type    = bool
  default = true
}

variable "parameters" {
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "immediate")
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
