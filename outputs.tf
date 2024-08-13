output "ec2_instance_public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = aws_instance.ec2_instances[*].public_ip
}

output "ec2_instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.ec2_instances[*].id
}
