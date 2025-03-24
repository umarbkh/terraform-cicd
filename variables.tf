variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
}

variable "regions" {
  description = "List of AWS regions"
  type        = list(string)
  default     = ["us-east-1", "us-west-1"]
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-01816d07b1128cd2d"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}

variable "users" {
  type = list(object({
    name     = string
    group    = string
    existing = optional(bool, false)
  }))
  default     = []
  description = "List of users to create or reference"
}