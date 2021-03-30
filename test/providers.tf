terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.34.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.3"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {}