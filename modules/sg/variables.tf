variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "addrule" {
  description = "List of predefined rules to add (e.g., ssh, http)"
  type        = list(string)
  default     = []
}

variable "custom_rules" {
  description = "List of custom rules"
  type = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}