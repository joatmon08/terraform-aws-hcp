provider "aws" {
  region = "us-west-2"
}

provider "boundary" {
  addr                   = var.boundary_addr
  auth_method_login_name = var.boundary_username
  auth_method_password   = var.boundary_password
}

run "boundary_worker" {
  command = apply
  module {
    source = "./modules/boundary-worker"
  }

  variables {
    name = "test"
  }

  assert {
    condition     = aws_instance.worker.instance_state == "running" || aws_instance.worker.instance_state == "pending"
    error_message = "Boundary worker is not running or pending"
  }
}
