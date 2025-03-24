variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "users" {
  type = list(object({
    name     = string
    group    = string
    existing = optional(bool, false)
  }))
  default     = []
  description = "List of IAM users to create or reference"
}