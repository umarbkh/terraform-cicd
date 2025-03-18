locals {
  ec2_policy = {
    name   = "${var.project_name}-ec2-policy"
    policy = file("${path.module}/ec2-policy.json")
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name        = local.ec2_policy.name
  policy      = local.ec2_policy.policy
}
