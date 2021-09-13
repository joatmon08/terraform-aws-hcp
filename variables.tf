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

variable "hvn_peer" {
  type        = bool
  description = "Peer HVN to VPC."
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC."
  default     = ""
}

variable "vpc_owner_id" {
  type        = string
  description = "Owner ID of VPC."
  default     = ""
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR Block of VPC. Cannot overlap with `hvn_cidr_block`."
  default     = ""
}

variable "route_table_ids" {
  type        = list(string)
  description = "List of routing table IDs to route to HVN peering connection."
  default     = []
}

variable "number_of_route_table_ids" {
  type        = number
  description = "Number of routing table ids. Works around GH-4149."
  default     = 0
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
  description = "Tier for HCP Consul cluster. Must be `development`, `standard`, or `plus`."
  default     = "development"
  validation {
    condition     = contains(["development", "standard", "plus"], var.hcp_consul_tier)
    error_message = "Not a valid option for hcp_vault_tier."
  }
}

variable "hcp_consul_version" {
  type        = string
  description = "Minimum Consul version. Defaults to HCP recommendation."
  default     = null
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

variable "hcp_vault_name" {
  type        = string
  description = "Name for HCP Vault cluster. If left as an empty string, a cluster will not be created."
  default     = ""
}

variable "hcp_vault_tier" {
  type        = string
  description = "Tier for HCP Vault cluster. See [pricing information](https://cloud.hashicorp.com/pricing/vault?_ga=2.162839740.1812223219.1631540747-2080033703.1609969902)"
  default     = "dev"
  validation {
    condition     = contains(["dev", "standard_small", "standard_medium", "standard_large", "starter_small"], var.hcp_vault_tier)
    error_message = "Not a valid option for hcp_vault_tier."
  }
}

variable "hcp_vault_version" {
  type        = string
  description = "Minimum Vault version. Defaults to HCP recommendation."
  default     = null
}


variable "hcp_vault_public_endpoint" {
  type        = bool
  description = "Enable public endpoint for HCP Vault cluster."
  default     = false
}
