output "hvn_id" {
  value       = hcp_hvn.hvn.id
  description = "ID of HashiCorp Virtual Network."
}


output "hcp_consul_id" {
  value       = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.cluster_id : ""
  description = "ID of HCP Consul."
}

output "hcp_consul_private_endpoint" {
  value       = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.consul_private_endpoint_url : ""
  description = "Private endpoint of HCP Consul."
}

output "hcp_consul_public_endpoint" {
  value       = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.consul_public_endpoint_url : ""
  description = "Private endpoint of HCP Consul."
}


output "hcp_vault_id" {
  value       = var.hcp_vault_name != "" ? hcp_vault_cluster.vault.0.cluster_id : ""
  description = "ID of HCP Vault."
}

output "hcp_vault_private_endpoint" {
  value       = var.hcp_vault_name != "" ? hcp_vault_cluster.vault.0.vault_private_endpoint_url : ""
  description = "Private endpoint of HCP Vault."
}

output "hcp_vault_public_endpoint" {
  value       = var.hcp_vault_name != "" ? hcp_vault_cluster.vault.0.vault_public_endpoint_url : ""
  description = "Private endpoint of HCP Vault."
}
