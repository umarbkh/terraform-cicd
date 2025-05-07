variable "project_name" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
variable "instance_class" {
  default = "db.t3.micro"
}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
