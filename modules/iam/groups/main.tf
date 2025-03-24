locals {
  common_groups = {
    admins = {
      name        = "${var.project_name}-admins"
      policy_arns = var.admin_policy_arns
    }
    developers = {
      name        = "${var.project_name}-developers"
      policy_arns = var.dev_policy_arns
    }
  }
}

resource "aws_iam_group" "group" {
  for_each = local.common_groups
  name     = each.value.name
}

resource "aws_iam_group_policy_attachment" "attach" {
  for_each   = local.common_groups
  group      = aws_iam_group.group[each.key].name
  policy_arn = each.value.policy_arns[0]
}
