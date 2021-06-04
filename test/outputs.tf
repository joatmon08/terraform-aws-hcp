output "hcp_consul" {
  value       = module.hcp_cluster.hcp_consul_id
  description = "HCP Consul cluster ID"
}

output "hcp_vault" {
  value       = module.hcp_cluster.hcp_vault_id
  description = "HCP Vault cluster ID"
}