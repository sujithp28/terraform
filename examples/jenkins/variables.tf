variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "environment" { type = string }
variable "project"     { type = string }
variable "owner"       { type = string; default = "platform-team" }
variable "vpc_id"      { type = string }
variable "subnet_id"   { type = string }
variable "instance_type" { type = string; default = "t3.large" }
variable "volume_size"   { type = number; default = 50 }
variable "key_name"      { type = string; default = "" }
variable "allowed_cidr_blocks" { type = list(string); default = ["10.0.0.0/8"] }
variable "eks_cluster_name"    { type = string; default = "" }
