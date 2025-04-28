variable "project_name" {
  type        = string
  description = "Project name to prefix resources"
}

variable "public_key" {
  description = "The public SSH key to associate with EC2 instances"
  type        = string
  default     = ""  # Default empty, meaning we won't use it.
}
