variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
}

variable "regions" {
  description = "List of AWS regions"
  type        = list(string)
  default     = ["us-east-1", "us-west-1"]
}