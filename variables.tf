## HVN Attributes

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

# Use transit gateway to connect VPC and HVN

variable "use_transit_gateway" {
  type        = bool
  description = "Use transit gateway for connecting HVN and VPC."
  default     = false
}

variable "transit_gateway_arn" {
  type        = string
  description = "Transit gateway ARN."
  default     = ""
}

variable "transit_gateway_id" {
  type        = string
  description = "Transit gateway ID."
  default     = ""
}

# Use peering to connect VPC and HVN

variable "hvn_peer" {
  type        = bool
  description = "Peer HVN to VPC."
  default     = false
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

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default     = {}
}

## HCP Consul Attributes

variable "hcp_consul_name" {
  type        = string
  description = "Name for HCP Consul cluster. If left as an empty string, a cluster will not be created."
  default     = null
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

variable "hcp_consul_peering" {
  type        = bool
  description = "Enable peering of HCP Consul clusters"
  default     = false
}

variable "hcp_consul_primary_link" {
  type        = string
  description = "`self_link` of the HCP Consul primary cluster for federation"
  default     = null
}

## HCP Vault Attributes

variable "hcp_vault_name" {
  type        = string
  description = "Name for HCP Vault cluster. If left as an empty string, a cluster will not be created."
  default     = null
}

variable "hcp_vault_tier" {
  type        = string
  description = "Tier for HCP Vault cluster. See [pricing information](https://cloud.hashicorp.com/pricing/vault?_ga=2.162839740.1812223219.1631540747-2080033703.1609969902)"
  default     = "dev"
  validation {
    condition     = contains(["dev", "standard_small", "standard_medium", "standard_large", "starter_small", "plus_small", "plus_medium", "plus_large"], var.hcp_vault_tier)
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

variable "hcp_vault_primary_link" {
  type        = string
  description = "`self_link` of the HCP Vault primary cluster for performance replication."
  default     = null
}

variable "hcp_vault_paths_filter" {
  type        = list(string)
  description = "Path filter for HCP Vault performance replication."
  default     = null
}

variable "datadog_api_key" {
  type        = string
  description = "Datadog API key for metrics and audit logs"
  sensitive   = true
  default     = null
}

variable "datadog_region" {
  type        = string
  description = "Datadog API key for metrics and audit logs"
  default     = null
}

## HCP Boundary Attributes

variable "hcp_boundary_name" {
  type        = string
  description = "Name for HCP Boundary cluster. If left as an empty string, a cluster will not be created."
  default     = null
}

variable "hcp_boundary_tier" {
  type        = string
  description = "HCP Boundary Tier"
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Plus"], var.hcp_boundary_tier)
    error_message = "Not a valid option for hcp_boundary_tier."
  }
}

locals {
  tags = merge({ module = "registry.terraform.io/modules/joatmon08/hcp/aws" }, var.tags)
  datadog_config = (var.datadog_api_key != null && var.datadog_region != null) ? [{
    api_key = var.datadog_api_key
    region  = var.datadog_region
  }] : []
}