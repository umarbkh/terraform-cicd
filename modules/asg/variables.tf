variable "project_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "iam_instance_profile" {}
variable "security_group_id" {}
variable "user_data" {}
variable "subnet_ids" {}
variable "elb_target_group_arn" {}
variable "tags" {}
variable "min_size" { default = 1 }
variable "max_size" { default = 3 }
variable "desired_capacity" { default = 2 }
