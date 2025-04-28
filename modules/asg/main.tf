# This module creates an AWS Auto Scaling Group (ASG) with a Launch Template and associated resources.
resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile {
    name = var.iam_instance_profile
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_group_id]
  }
  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      {
        "Name" = "${var.project_name}-ec2"
      },
      var.tags
    )
  }
}

# Create an Auto Scaling Group (ASG) with the Launch Template
resource "aws_autoscaling_group" "this" {
  name_prefix          = "${var.project_name}-asg-"
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  target_group_arns    = [var.elb_target_group_arn]
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  # Add Name tag to EC2 instances in the ASG
  tag {
    key                 = "Name"
    value               = "${var.project_name}-ec2"
    propagate_at_launch = true
  }

  # Add dynamic tags from var.tags
  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
