output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  value = aws_subnet.custom_subnet.id
}

output "SSHsecurityGroupID" {
  value = aws_security_group.vpc-ssh.id
}

output "WEBsecurityGroupID" {
  value = aws_security_group.web-traffic.id
}