output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "security_group_id" {
  value = module.sg.security_group_id
}

# output "ec2_instance_id" {
#   value = module.ec2.ec2_instance_id
# }

# output "ec2_instance_public_ip" {
#   value = module.ec2.ec2_instance_public_ip
# }

# output "webpage_url" {
#   value = "http://${join(", ", module.ec2.ec2_instance_public_ip)}"
# }
