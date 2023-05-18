output "instance_public_ip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.myec2vm.public_ip
}

output "instance_public_dns" {
  description = "EC2 Instance Public dns"
  value = aws_instance.myec2vm.public_dns
}

output "Instance_id" {
  description = "EC2 Instance ID"
  value = aws_instance.myec2vm.id
}