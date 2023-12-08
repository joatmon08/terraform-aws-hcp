output "worker" {
  value       = aws_instance.worker
  description = "EC2 instance information about Boundary worker"
}

output "security_group_id" {
  value       = var.worker_security_group_id != null ? var.worker_security_group_id : aws_security_group.worker.0.id
  description = "Security group for worker"
}

output "boundary_worker_id" {
  value       = boundary_worker.worker.id
  description = "Boundary worker ID"
}
