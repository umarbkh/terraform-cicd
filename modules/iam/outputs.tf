output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "group_names" {
  value = module.groups.group_names
}
