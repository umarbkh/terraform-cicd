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

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "tags" {
  description = "Additional tags for the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script for the EC2 instance"
  type        = string
  default     = ""
}