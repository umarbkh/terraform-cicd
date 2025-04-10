resource "aws_instance" "ec2_instance" {
  count                  = var.instance_count  # Create EC2 instances based on count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id, var.load_balancer_sg_id]  # Attach both SGs
  iam_instance_profile   = var.iam_instance_profile
  user_data              = var.user_data
  tags                   = merge(var.tags, {
    Name = "${var.project_name}-ec2-${count.index + 1}"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "ec2_target" {
  count            = var.instance_count  # Attach each EC2 instance to the target group
  target_group_arn = var.elb_target_group_arn
  target_id        = aws_instance.ec2_instance[count.index].id
  port             = 80  # Port your EC2 is listening on
}
