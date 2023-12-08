variable "consul_primary_name" {
  type = string
}

variable "consul_primary_address" {
  type = string
}

variable "consul_primary_datacenter" {
  type = string
}

variable "consul_primary_token" {
  type      = string
  sensitive = true
}

variable "consul_secondary_name" {
  type = string
}

variable "consul_secondary_address" {
  type = string
}

variable "consul_secondary_datacenter" {
  type = string
}

variable "consul_secondary_token" {
  type      = string
  sensitive = true
}