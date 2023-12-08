resource "hcp_consul_cluster_root_token" "primary" {
  cluster_id = module.hcp_cluster_primary.hcp_consul_id
}

resource "hcp_consul_cluster_root_token" "secondary" {
  cluster_id = module.hcp_cluster_secondary.hcp_consul_id
}

resource "local_file" "outputs" {
  content  = <<EOT
consul_primary_name = "${module.hcp_cluster_primary.hcp_consul_id}"
consul_primary_address = "${module.hcp_cluster_primary.hcp_consul_public_endpoint}"
consul_primary_datacenter = "${module.hcp_cluster_primary.hcp_consul_datacenter}"
consul_primary_token = "${hcp_consul_cluster_root_token.primary.secret_id}"

consul_secondary_name = "${module.hcp_cluster_secondary.hcp_consul_id}"
consul_secondary_address = "${module.hcp_cluster_secondary.hcp_consul_public_endpoint}"
consul_secondary_datacenter = "${module.hcp_cluster_secondary.hcp_consul_datacenter}"
consul_secondary_token = "${hcp_consul_cluster_root_token.secondary.secret_id}"
EOT
  filename = "./consul/secrets.auto.tfvars"
}