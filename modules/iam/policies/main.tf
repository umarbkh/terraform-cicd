locals {
  ec2_policy = {
    name   = "${var.project_name}-ec2-policy"
    policy = file("${path.module}/ec2-policy.json")
  }

  admin_policy = {
    name   = "${var.project_name}-admin-policy"
    policy = file("${path.module}/admin-policy.json")
  }

  dev_policy = {
    name   = "${var.project_name}-dev-policy"
    policy = file("${path.module}/dev-policy.json")
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name   = local.ec2_policy.name
  policy = local.ec2_policy.policy
}

resource "aws_iam_policy" "admin_policy" {
  name   = local.admin_policy.name
  policy = local.admin_policy.policy
}

resource "aws_iam_policy" "dev_policy" {
  name   = local.dev_policy.name
  policy = local.dev_policy.policy
}
