resource "local_file" "ids" {
  filename = "../secrets.auto.tfvars"
  content  = <<EOT
boundary_cluster_id     = "${module.hcp.boundary.id}"
boundary_addr           = "${module.hcp.boundary.public_endpoint}"
boundary_username       = "${module.hcp.boundary.username}"
boundary_password       = "${module.hcp.boundary.password}"
vpc_id                  = "${module.vpc.vpc_id}"
worker_public_subnet_id = "${module.vpc.public_subnets.0}"
worker_keypair_name     = "${aws_key_pair.boundary.key_name}"
EOT
}

output "ssh_private_key" {
  value       = base64encode(tls_private_key.boundary.private_key_openssh)
  description = "Boundary worker SSH key"
  sensitive   = true
}