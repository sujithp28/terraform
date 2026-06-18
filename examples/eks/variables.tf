variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "myproject"
}

variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "system_desired_size" {
  description = "Desired number of system nodes"
  type        = number
  default     = 3
}

variable "system_min_size" {
  description = "Minimum number of system nodes"
  type        = number
  default     = 3
}

variable "system_max_size" {
  description = "Maximum number of system nodes"
  type        = number
  default     = 10
}

variable "system_instance_types" {
  description = "Instance types for system nodes"
  type        = list(string)
  default     = ["t3.medium", "t3a.medium"]
}

variable "enable_application_node_group" {
  description = "Enable application node group"
  type        = bool
  default     = true
}

variable "application_desired_size" {
  description = "Desired number of application nodes"
  type        = number
  default     = 3
}

variable "application_min_size" {
  description = "Minimum number of application nodes"
  type        = number
  default     = 1
}

variable "application_max_size" {
  description = "Maximum number of application nodes"
  type        = number
  default     = 20
}

variable "application_instance_types" {
  description = "Instance types for application nodes"
  type        = list(string)
  default     = ["t3.large", "t3a.large"]
}

variable "enable_gpu_node_group" {
  description = "Enable GPU node group"
  type        = bool
  default     = false
}

variable "gpu_desired_size" {
  description = "Desired number of GPU nodes"
  type        = number
  default     = 0
}

variable "gpu_min_size" {
  description = "Minimum number of GPU nodes"
  type        = number
  default     = 0
}

variable "gpu_max_size" {
  description = "Maximum number of GPU nodes"
  type        = number
  default     = 5
}

variable "gpu_instance_types" {
  description = "Instance types for GPU nodes"
  type        = list(string)
  default     = ["g4dn.xlarge"]
}

variable "endpoint_private_access" {
  description = "Enable private API endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public API endpoint"
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "Public access CIDRs"
  type        = list(string)
  default     = []
}

variable "cluster_endpoint_private_access_cidrs" {
  description = "Private access CIDRs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_enabled_log_types" {
  description = "Cluster log types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "cluster_log_retention_in_days" {
  description = "CloudWatch log retention days"
  type        = number
  default     = 30
}

variable "enable_efs_csi_driver" {
  description = "Enable EFS CSI driver"
  type        = bool
  default     = false
}

variable "iam_role_permissions_boundary" {
  description = "IAM role permissions boundary"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
