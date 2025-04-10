output "ec2_instance_id" {
  value = [for i in aws_instance.ec2_instance : i.id]
}

output "ec2_instance_public_ip" {
  value = [for i in aws_instance.ec2_instance : i.public_ip]
}
