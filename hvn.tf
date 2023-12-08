resource "hcp_hvn" "hvn" {
  hvn_id         = var.hvn_name
  cloud_provider = "aws"
  region         = var.hvn_region
  cidr_block     = var.hvn_cidr_block

  lifecycle {
    precondition {
      condition     = var.hvn_cidr_block != var.vpc_cidr_block
      error_message = "HCP HVN must not overlap with VPC CIDR block"
    }
  }
}