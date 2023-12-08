variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_id" {
  type = string
}

variable "worker_public_subnet_id" {
  type = string
}

variable "worker_keypair_name" {
  type = string
}

variable "boundary_addr" {
  type = string
}

variable "boundary_username" {
  type = string
}

variable "boundary_password" {
  type      = string
  sensitive = true
}
