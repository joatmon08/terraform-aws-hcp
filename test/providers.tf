terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.14"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.29"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {}