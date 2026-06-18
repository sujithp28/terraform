variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,100}$", var.cluster_name))
    error_message = "Cluster name must be 1-100 characters and contain only alphanumeric characters and hyphens."
  }
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.29"
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS cluster"
  type        = list(string)
  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "At least 2 private subnets are required for high availability."
  }
}

variable "cluster_endpoint_private_access_cidrs" {
  description = "List of CIDR blocks that can access the cluster endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "endpoint_private_access" {
  description = "Enable private API server endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks that can access the public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_enabled_log_types" {
  description = "List of control plane logging types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "cluster_log_retention_in_days" {
  description = "CloudWatch log group retention in days"
  type        = number
  default     = 30
}

variable "kms_key_deletion_window_in_days" {
  description = "KMS key deletion window in days"
  type        = number
  default     = 30
  validation {
    condition     = var.kms_key_deletion_window_in_days >= 7 && var.kms_key_deletion_window_in_days <= 30
    error_message = "KMS key deletion window must be between 7 and 30 days."
  }
}

# System Node Group Variables
variable "system_desired_size" {
  description = "Desired number of nodes in system node group"
  type        = number
  default     = 3
  validation {
    condition     = var.system_desired_size >= 3
    error_message = "System node group must have at least 3 nodes for high availability."
  }
}

variable "system_min_size" {
  description = "Minimum number of nodes in system node group"
  type        = number
  default     = 3
}

variable "system_max_size" {
  description = "Maximum number of nodes in system node group"
  type        = number
  default     = 10
}

variable "system_instance_types" {
  description = "Instance types for system node group"
  type        = list(string)
  default     = ["t3.medium", "t3a.medium"]
}

variable "system_disk_size" {
  description = "Disk size in GiB for system node group"
  type        = number
  default     = 100
}

# Application Node Group Variables
variable "enable_application_node_group" {
  description = "Enable application node group"
  type        = bool
  default     = true
}

variable "application_desired_size" {
  description = "Desired number of nodes in application node group"
  type        = number
  default     = 3
}

variable "application_min_size" {
  description = "Minimum number of nodes in application node group"
  type        = number
  default     = 1
}

variable "application_max_size" {
  description = "Maximum number of nodes in application node group"
  type        = number
  default     = 20
}

variable "application_instance_types" {
  description = "Instance types for application node group"
  type        = list(string)
  default     = ["t3.large", "t3a.large"]
}

variable "application_disk_size" {
  description = "Disk size in GiB for application node group"
  type        = number
  default     = 100
}

# GPU Node Group Variables
variable "enable_gpu_node_group" {
  description = "Enable GPU node group"
  type        = bool
  default     = false
}

variable "gpu_desired_size" {
  description = "Desired number of nodes in GPU node group"
  type        = number
  default     = 0
}

variable "gpu_min_size" {
  description = "Minimum number of nodes in GPU node group"
  type        = number
  default     = 0
}

variable "gpu_max_size" {
  description = "Maximum number of nodes in GPU node group"
  type        = number
  default     = 5
}

variable "gpu_instance_types" {
  description = "Instance types for GPU node group"
  type        = list(string)
  default     = ["g4dn.xlarge"]
}

variable "gpu_disk_size" {
  description = "Disk size in GiB for GPU node group"
  type        = number
  default     = 200
}

# Add-on Variables
variable "vpc_cni_addon_version" {
  description = "VPC CNI add-on version"
  type        = string
  default     = null
}

variable "coredns_addon_version" {
  description = "CoreDNS add-on version"
  type        = string
  default     = null
}

variable "kube_proxy_addon_version" {
  description = "kube-proxy add-on version"
  type        = string
  default     = null
}

variable "ebs_csi_driver_addon_version" {
  description = "EBS CSI driver add-on version"
  type        = string
  default     = null
}

variable "enable_efs_csi_driver" {
  description = "Enable EFS CSI driver add-on"
  type        = bool
  default     = false
}

variable "efs_csi_driver_addon_version" {
  description = "EFS CSI driver add-on version"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for IAM roles"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
