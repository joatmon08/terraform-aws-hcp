resource "boundary_worker" "worker" {
  scope_id                    = var.boundary_scope_id
  name                        = var.name
  description                 = "Self-managed worker using controller-led registration"
  worker_generated_auth_token = ""
}
