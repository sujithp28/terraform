variable "aws_region"        { type = string; default = "us-east-1" }
variable "environment"       { type = string }
variable "project"           { type = string }
variable "owner"             { type = string; default = "platform-team" }
variable "bucket_name"       { type = string }
variable "enable_versioning" { type = bool;   default = true }
variable "enable_replication" { type = bool;  default = false }
variable "iam_roles" {
  type = map(object({
    description         = string
    trusted_services    = list(string)
    managed_policy_arns = list(string)
  }))
  default = {}
}
