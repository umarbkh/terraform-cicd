variable "name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ELB and target group will be created"
  type        = string
}

variable "subnets" {
  description = "List of subnets for the load balancer"
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID to attach to the load balancer"
  type        = string
}

variable "instance_ports" {
  description = "List of ports that the EC2 instances will be listening on"
  type        = list(number)
  default     = [80]
}

variable "health_check_path" {
  description = "Path for the health check"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags to apply to the ELB and resources"
  type        = map(string)
  default     = {}
}
