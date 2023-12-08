terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "boundary" {
  addr                   = var.boundary_addr
  auth_method_login_name = var.boundary_username
  auth_method_password   = var.boundary_password
}
