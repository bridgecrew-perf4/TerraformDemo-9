##################################################
# Terraform
##################################################
terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

##################################################
# Provider
##################################################
provider "aws" {
  region = var.demo-region
}

