variable "users" {
  type = list(object({
    name  = string
    group = string,
    existing = optional(bool, false)
  }))
}

variable "groups" {
  type = map(object({
    name        = string
    policy_arns = list(string)
  }))
}

variable "project_name" {
  type = string
}
