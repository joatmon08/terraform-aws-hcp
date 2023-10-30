locals {
  name = "terraform-aws-hcp-module-test"
  tags = {
    module  = "joatmon08/terraform-aws-hcp"
    purpose = "module-testing"
  }
}

resource "random_pet" "test" {
  length = 1
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_ec2_transit_gateway" "primary" {
  tags = {
    Name = local.name
  }
}

module "vpc_primary" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name                 = local.name
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.10.0/24", "10.0.11.0/24"]
  public_subnets       = ["10.0.12.0/24", "10.0.13.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = false
  enable_dns_hostnames = true

  tags = local.tags
}

resource "aws_ec2_transit_gateway_vpc_attachment" "primary" {
  subnet_ids         = module.vpc_primary.private_subnets
  transit_gateway_id = aws_ec2_transit_gateway.primary.id
  vpc_id             = module.vpc_primary.vpc_id
}

module "hcp_cluster_primary" {
  source     = "./.."
  depends_on = [aws_ec2_transit_gateway.primary]

  hvn_region     = var.primary_region
  hvn_name       = var.primary_region
  hvn_cidr_block = "172.26.16.0/20"

  use_transit_gateway = true
  transit_gateway_arn = aws_ec2_transit_gateway.primary.arn
  transit_gateway_id  = aws_ec2_transit_gateway.primary.id

  tags = local.tags

  hcp_consul_name            = "${random_pet.test.id}-${var.primary_region}"
  hcp_consul_tier            = "plus"
  hcp_consul_public_endpoint = true

  hcp_vault_name            = "${random_pet.test.id}-${var.primary_region}"
  hcp_vault_tier            = "plus_small"
  hcp_vault_public_endpoint = true

  hcp_boundary_name = local.name
}

data "aws_availability_zones" "available_secondary" {
  provider = aws.secondary
  state    = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_ec2_transit_gateway" "secondary" {
  provider = aws.secondary
  tags = {
    Name = local.name
  }
}

module "vpc_secondary" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  providers = {
    aws = aws.secondary
  }

  name                 = local.name
  cidr                 = "10.1.0.0/16"
  azs                  = data.aws_availability_zones.available_secondary.names
  private_subnets      = ["10.1.10.0/24", "10.1.11.0/24"]
  public_subnets       = ["10.1.12.0/24", "10.1.13.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = false
  enable_dns_hostnames = true

  tags = local.tags
}

resource "aws_ec2_transit_gateway_vpc_attachment" "secondary" {
  provider           = aws.secondary
  subnet_ids         = module.vpc_secondary.private_subnets
  transit_gateway_id = aws_ec2_transit_gateway.secondary.id
  vpc_id             = module.vpc_secondary.vpc_id
}

resource "aws_ec2_transit_gateway_peering_attachment" "primary_to_secondary" {
  peer_account_id         = aws_ec2_transit_gateway.secondary.owner_id
  peer_region             = var.secondary_region
  peer_transit_gateway_id = aws_ec2_transit_gateway.secondary.id
  transit_gateway_id      = aws_ec2_transit_gateway.primary.id

  tags = {
    Name = "primary-to-secondary"
  }
}

module "hcp_cluster_secondary" {
  depends_on = [aws_ec2_transit_gateway.secondary, module.hcp_cluster_primary]
  source     = "./.."

  providers = {
    aws = aws.secondary
  }

  hvn_region     = var.secondary_region
  hvn_name       = var.secondary_region
  hvn_cidr_block = "172.26.32.0/20"

  use_transit_gateway = true
  transit_gateway_arn = aws_ec2_transit_gateway.secondary.arn
  transit_gateway_id  = aws_ec2_transit_gateway.secondary.id

  tags = local.tags

  hcp_consul_name            = "${random_pet.test.id}-${var.secondary_region}"
  hcp_consul_tier            = "plus"
  hcp_consul_public_endpoint = true

  hcp_vault_name            = "${random_pet.test.id}-${var.secondary_region}"
  hcp_vault_tier            = "plus_small"
  hcp_vault_public_endpoint = true
  hcp_vault_primary_link    = module.hcp_cluster_primary.hcp_vault_self_link
}
