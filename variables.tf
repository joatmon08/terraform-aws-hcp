variable "hvn_cidr_block" {
  type        = string
  description = "CIDR Block of HashiCorp Virtual Network"
}

variable "vpc_id" {
  type        = string
  description = "The ID of your VPC"
}

variable "route_table_ids" {
  type        = set(string)
  description = "Set of routing table IDs to route to HVN peering connection"
}

variable "consul_security_group_name" {
  type        = string
  description = "Name of HCP Consul security group"
  default     = "allow-hcp-consul"
}

variable "consul_security_group_ids" {
  type        = list(string)
  description = "List of security groups to allow HCP Consul connection"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Map of tags for resources"
  default     = { module = "terraform-aws-consul" }
}