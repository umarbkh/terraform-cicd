output "security_group_id" {
  value = tolist(aws_lb.main.security_groups)[0]
}


output "target_group_arn" {
  description = "The ARN of the target group created by the load balancer"
  value       = aws_lb_target_group.main[0].arn
}

output "load_balancer_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.main.arn
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}
