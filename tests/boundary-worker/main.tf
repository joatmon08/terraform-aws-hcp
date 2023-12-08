module "worker" {
  source                  = "../../modules/boundary-worker"
  name                    = "test"
  boundary_addr           = var.boundary_addr
  vpc_id                  = var.vpc_id
  worker_public_subnet_id = var.worker_public_subnet_id
  worker_keypair_name     = var.worker_keypair_name
}
