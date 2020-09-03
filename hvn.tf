data "aws_vpc_peering_connection" "hvn" {
  cidr_block  = var.hvn_cidr_block
  peer_vpc_id = var.vpc_id
}

resource "aws_vpc_peering_connection_accepter" "hvn" {
  vpc_peering_connection_id = data.aws_vpc_peering_connection.hvn.id
  auto_accept               = true
  tags                      = var.tags
}

resource "aws_route" "hvn" {
  count                     = length(var.route_table_ids)
  route_table_id            = var.route_table_ids[count.index]
  destination_cidr_block    = var.hvn_cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection.hvn.id
}