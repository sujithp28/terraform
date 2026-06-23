variable "aws_region"      { type = string; default = "us-east-1" }
variable "environment"     { type = string }
variable "project"         { type = string }
variable "alarm_email"     { type = string }
variable "eks_cluster_name" { type = string; default = "" }
variable "rds_instance_id"  { type = string; default = "" }
