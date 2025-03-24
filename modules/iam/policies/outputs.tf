output "ec2_policy_arn" {
  value = aws_iam_policy.ec2_policy.arn
}

output "admin_policy_arn" {
  value = aws_iam_policy.admin_policy.arn
}

output "dev_policy_arn" {
  value = aws_iam_policy.dev_policy.arn
}
