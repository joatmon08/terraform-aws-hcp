output "hvn_id" {
  value       = hcp_hvn.hvn.id
  description = "ID of HashiCorp Virtual Network."
}


output "hcp_cluster_id" {
  value       = var.hcp_consul_name != "" ? hcp_consul_cluster.consul.0.id : ""
  description = "ID of HCP Consul cluster."
}
