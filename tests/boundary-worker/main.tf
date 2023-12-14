module "worker" {
  source                  = "../../modules/boundary-worker"
  name                    = "test"
  boundary_addr           = var.boundary_addr
  vpc_id                  = var.vpc_id
  worker_public_subnet_id = var.worker_public_subnet_id
  worker_keypair_name     = var.worker_keypair_name
  boundary_username       = var.boundary_username
  boundary_password       = var.boundary_password
}

resource "aws_security_group_rule" "allow_boundary_worker_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.worker.security_group_id
}