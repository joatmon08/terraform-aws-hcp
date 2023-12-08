module "hcp" {
  source                    = "../../."
  hvn_region                = var.region
  hvn_name                  = var.name
  hvn_cidr_block            = "172.25.16.0/20"
  hcp_boundary_name         = var.name
  hvn_peer                  = true
  vpc_id                    = module.vpc.vpc_id
  vpc_cidr_block            = module.vpc.vpc_cidr_block
  vpc_owner_id              = module.vpc.vpc_owner_id
  route_table_ids           = module.vpc.private_route_table_ids
  number_of_route_table_ids = length(module.vpc.private_route_table_ids)
}