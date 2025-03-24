output "user_arns" {
  value = merge(
    { for k, v in aws_iam_user.new : k => v.arn },
    { for k, v in data.aws_iam_user.existing : k => v.arn }
  )
}

output "all_usernames" {
  value = merge(
    { for k, v in aws_iam_user.new : k => v.name },
    { for k, v in data.aws_iam_user.existing : k => v.user_name }
  )
}