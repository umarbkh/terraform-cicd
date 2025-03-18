locals {
  common_roles = {
    ec2_role = {
      name  = "${var.project_name}-ec2-role"
      policy_arns = [var.ec2_policy_arn]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name = local.common_roles.ec2_role.name
  assume_role_policy = file("${path.module}/ec2-assume-role.json")
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = local.common_roles.ec2_role.policy_arns[0]
}
