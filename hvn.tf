resource "hcp_hvn" "hvn" {
  hvn_id         = var.hvn_name
  cloud_provider = "aws"
  region         = var.hvn_region
  cidr_block     = var.hvn_cidr_block
}

data "aws_region" "current" {}

resource "hcp_aws_network_peering" "peer" {
  count           = var.hvn_peer ? 1 : 0
  hvn_id          = hcp_hvn.hvn.hvn_id
  peer_vpc_id     = var.vpc_id
  peer_account_id = var.vpc_owner_id
  peer_vpc_region = data.aws_region.current.name
  peering_id      = var.hvn_name
}

resource "aws_vpc_peering_connection_accepter" "hvn" {
  count                     = var.hvn_peer ? 1 : 0
  vpc_peering_connection_id = hcp_aws_network_peering.peer.0.provider_peering_id
  auto_accept               = true
  tags                      = local.tags
}

resource "aws_route" "hvn" {
  count                     = var.number_of_route_table_ids
  route_table_id            = var.route_table_ids[count.index]
  destination_cidr_block    = var.hvn_cidr_block
  vpc_peering_connection_id = hcp_aws_network_peering.peer.0.provider_peering_id
}

resource "hcp_hvn_route" "hvn" {
  count            = var.hvn_peer ? 1 : 0
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = "${var.hvn_name}-to-vpc"
  destination_cidr = var.vpc_cidr_block
  target_link      = hcp_aws_network_peering.peer.0.self_link
}