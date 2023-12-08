output "hvn" {
  value = {
    id         = hcp_hvn.hvn.id
    region     = hcp_hvn.hvn.region
    cidr_block = hcp_hvn.hvn.cidr_block
  }
  description = "HVN attributes"
}

## HCP Consul Attributes

output "consul" {
  value = {
    id               = try(hcp_consul_cluster.consul.0.cluster_id, "")
    self_link        = try(hcp_consul_cluster.consul.0.self_link, "")
    private_endpoint = try(hcp_consul_cluster.consul.0.consul_private_endpoint_url, "")
    public_endpoint  = try(hcp_consul_cluster.consul.0.consul_public_endpoint_url, "")
    datacenter       = try(hcp_consul_cluster.consul.0.datacenter, "")
    token            = try(hcp_consul_cluster.consul.0.consul_root_token_secret_id, "")
  }
  description = "HCP Consul cluster attributes"
  sensitive   = true
}

output "vault" {
  value = {
    id               = try(hcp_vault_cluster.vault.0.cluster_id, "")
    self_link        = try(hcp_vault_cluster.vault.0.self_link, "")
    private_endpoint = try(hcp_vault_cluster.vault.0.vault_private_endpoint_url, "")
    public_endpoint  = try(hcp_vault_cluster.vault.0.vault_public_endpoint_url, "")
    namespace        = try(hcp_vault_cluster.vault.0.namespace, "")
  }
  description = "HCP Vault cluster attributes"
  sensitive   = true
}

output "boundary" {
  value = {
    id              = try(hcp_boundary_cluster.boundary.0.cluster_id, "")
    public_endpoint = try(hcp_boundary_cluster.boundary.0.cluster_url, "")
    username        = try(hcp_boundary_cluster.boundary.0.username, "")
    password        = try(hcp_boundary_cluster.boundary.0.password, "")
  }
  description = "HCP Boundary cluster attributes"
  sensitive   = true
}
