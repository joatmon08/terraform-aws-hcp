resource "consul_peering_token" "primary" {
  provider  = consul.primary
  peer_name = var.consul_secondary_name
}

resource "consul_peering" "secondary" {
  provider = consul.secondary

  peer_name     = var.consul_secondary_name
  peering_token = consul_peering_token.primary.peering_token
}