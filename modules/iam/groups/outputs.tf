output "group_names" {
  value = { for k, v in aws_iam_group.group : k => v.name }
}

output "common_groups" {
  value = local.common_groups
}
