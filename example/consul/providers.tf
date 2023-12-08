terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.19"
    }
  }
}

provider "consul" {
  alias      = "primary"
  address    = var.consul_primary_address
  datacenter = var.consul_primary_datacenter
  token      = var.consul_primary_token
}

provider "consul" {
  alias      = "secondary"
  address    = var.consul_secondary_address
  datacenter = var.consul_secondary_datacenter
  token      = var.consul_secondary_token
}