variable "hvn_cidr_block" {
  type        = string
  description = "CIDR Block of HashiCorp Virtual Network"
}

variable "vpc_id" {
  type        = string
  description = "The ID of your VPC"
}

variable "route_table_ids" {
  type        = list(string)
  description = "List of routing table IDs to route to HVN peering connection"
}

variable "number_of_route_table_ids" {
  type        = number
  description = "Number of routing table ids. Works around GH-4149"
}

variable "hcp_consul_security_group_ids" {
  type        = list(string)
  description = "Security Group IDs to add HCP Consul security group rules"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Map of tags for resources"
  default     = { module = "terraform-aws-hcp" }
}