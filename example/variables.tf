variable "primary_region" {
  type        = string
  description = "Primary cluster region"
  default     = "us-east-1"
}

variable "secondary_region" {
  type        = string
  description = "Secondary cluster region"
  default     = "eu-west-1"
}