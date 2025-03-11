output "availability_zones" {
  description = "List of availability zones for the specified region"
  value       = data.aws_availability_zones.available.names
}