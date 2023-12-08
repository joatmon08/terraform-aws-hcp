variable "name" {
  type        = string
  description = "Name of resources"
  default     = "test-terraform-aws-hcp"
}

variable "owner" {
  type        = string
  description = "Owner of resources"
}

variable "region" {
  type        = string
  description = "Region for resources"
  default     = "us-west-2"
}
