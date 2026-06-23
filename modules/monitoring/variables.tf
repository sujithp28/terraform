variable "name" {
  description = "Name prefix for monitoring resources"
  type        = string
}

variable "alarm_email" {
  description = "Email address to receive CloudWatch alarm notifications"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name to monitor (leave empty to skip EKS alarms)"
  type        = string
  default     = ""
}

variable "rds_instance_id" {
  description = "RDS instance identifier to monitor (leave empty to skip RDS alarms)"
  type        = string
  default     = ""
}

variable "rds_cpu_threshold" {
  description = "RDS CPU utilization alarm threshold (%)"
  type        = number
  default     = 80
}

variable "rds_storage_threshold" {
  description = "RDS free storage alarm threshold (bytes)"
  type        = number
  default     = 10737418240   # 10 GB
}

variable "log_retention_days" {
  description = "CloudWatch log retention period in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
