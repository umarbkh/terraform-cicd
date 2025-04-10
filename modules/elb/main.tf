resource "aws_lb" "main" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnets
  enable_deletion_protection = false
  idle_timeout = 60

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_lb_target_group" "main" {
  count    = length(var.instance_ports)
  name     = "${var.name}-target-group-${count.index}"
  port     = var.instance_ports[count.index]
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.name}-target-group-${count.index}"
  }
}

resource "aws_lb_listener" "http" {
  count             = length(var.instance_ports)
  load_balancer_arn = aws_lb.main.arn
  port              = var.instance_ports[count.index]
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[count.index].arn
  }
}

