output "group_names" {
  value = { for k, v in aws_iam_group.group : k => v.name }
}
