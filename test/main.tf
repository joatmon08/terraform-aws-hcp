locals {
  name = "terraform-aws-hcp-module-test"
  tags = {
    module  = "joatmon08/terraform-aws-hcp"
    purpose = "module-testing"
  }
  route_table_ids = concat(module.vpc.private_route_table_ids, module.vpc.public_route_table_ids)
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

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

module "hcp_cluster" {
  source                    = "./.."
  hvn_region                = var.region
  hvn_name                  = local.name
  hvn_cidr_block            = "172.25.16.0/20"
  vpc_id                    = module.vpc.vpc_id
  vpc_owner_id              = module.vpc.vpc_owner_id
  vpc_cidr_block            = module.vpc.vpc_cidr_block
  route_table_ids           = local.route_table_ids
  number_of_route_table_ids = length(local.route_table_ids)
  tags                      = local.tags
  hcp_consul_name           = local.name
  hcp_vault_name            = local.name
}