terraform {
  # Require Terraform CLI version
  required_version = ">= 0.12"

  # Required providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Allow 3.x versions only
    }
    # Random provider for generating random values for services
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region = "us-west-2"
}