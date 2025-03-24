variable "project_name" {
  type = string
}

variable "admin_policy_arns" {
  type = list(string)
}

variable "dev_policy_arns" {
  type = list(string)
}
