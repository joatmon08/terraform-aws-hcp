resource "local_file" "terraform_test" {
  filename = "../secrets.auto.tfvars"
  content  = <<EOT
boundary_addr           = "${module.hcp.boundary.public_endpoint}"
boundary_username       = "${module.hcp.boundary.username}"
boundary_password       = "${module.hcp.boundary.password}"
vpc_id                  = "${module.vpc.vpc_id}"
worker_public_subnet_id = "${module.vpc.public_subnets.0}"
worker_keypair_name     = "${aws_key_pair.boundary.key_name}"
EOT
}

resource "local_file" "boundary_worker_tests" {
  filename = "../boundary-worker/secrets.auto.tfvars"
  content  = <<EOT
boundary_addr           = "${module.hcp.boundary.public_endpoint}"
boundary_username       = "${module.hcp.boundary.username}"
boundary_password       = "${module.hcp.boundary.password}"
vpc_id                  = "${module.vpc.vpc_id}"
worker_public_subnet_id = "${module.vpc.public_subnets.0}"
worker_keypair_name     = "${aws_key_pair.boundary.key_name}"
EOT
}

resource "local_file" "boundary_worker_ssh" {
  filename        = "../boundary-worker/secrets/id_rsa.pem"
  content         = tls_private_key.boundary.private_key_openssh
  file_permission = 400
}
