# Create new users (with project prefix)
resource "aws_iam_user" "new" {
  for_each = { 
    for user in var.users : user.name => user 
    if !user.existing
  }
  name = "${var.project_name}-${each.value.name}"
}

# Reference existing users (without project prefix)
data "aws_iam_user" "existing" {
  for_each = { 
    for user in var.users : user.name => user 
    if user.existing
  }
  user_name = each.value.name
}

# Group membership for all users
resource "aws_iam_group_membership" "this" {
  for_each = { 
    for user in var.users : user.name => user 
    if user.group != ""
  }

  name  = "${var.project_name}-${each.value.group}-membership"
  users = [each.value.existing ? each.value.name : aws_iam_user.new[each.key].name]
  group = var.groups[each.value.group].name
}