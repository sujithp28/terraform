# This example calls the RDS flat-root config directly.
# To deploy: copy terraform.tfvars.example -> terraform.tfvars and run terraform apply from the repo root.

provider "aws" {
  region = var.aws_region
}
