variable "hvn_region" {
  type        = string
  description = "AWS region for HashiCorp Virtual Network."
}
variable "hvn_name" {
  type        = string
  description = "Name of HashiCorp Virtual Network."
}

variable "hvn_cidr_block" {
  type        = string
  description = "CIDR Block of HashiCorp Virtual Network. Cannot overlap with `vpc_cidr_block`."
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC."
}

variable "vpc_owner_id" {
  type        = string
  description = "Owner ID of VPC."
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR Block of VPC. Cannot overlap with `hvn_cidr_block`."
}

variable "route_table_ids" {
  type        = list(string)
  description = "List of routing table IDs to route to HVN peering connection."
}

variable "number_of_route_table_ids" {
  type        = number
  description = "Number of routing table ids. Works around GH-4149."
}

variable "hcp_consul_name" {
  type        = string
  description = "Name for HCP Consul cluster. If left as an empty string, a cluster will not be created."
  default     = ""
}

variable "hcp_consul_datacenter" {
  type        = string
  description = "Datacenter for HCP Consul cluster. If undefined, uses `hcp_consul_name`."
  default     = null
}

variable "hcp_consul_security_group_ids" {
  type        = list(string)
  description = "Security Group IDs to allow HCP Consul."
  default     = []
}

variable "hcp_consul_tier" {
  type        = string
  description = "Tier for HCP Consul cluster. Must be `development` or `standard`."
  default     = "development"
  validation {
    condition     = var.hcp_consul_tier != "development" || var.hcp_consul_tier != "standard"
    error_message = "The hcp_consul_tier value must be \"development\" or \"standard\"."
  }
}

variable "hcp_consul_public_endpoint" {
  type        = bool
  description = "Enable public endpoint for HCP Consul cluster."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Map of tags for resources"
  default     = { module = "terraform-aws-hcp" }
}