resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  user_data     = var.user_data
  tags = merge(var.tags, {
    Name = "${var.project_name}-ec2"
  })
}