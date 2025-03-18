module "policies" {
  source       = "./policies"
  project_name = var.project_name
}

module "roles" {
  source       = "./roles"
  project_name = var.project_name
  ec2_policy_arn = module.policies.ec2_policy_arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = module.roles.ec2_role_name
}
