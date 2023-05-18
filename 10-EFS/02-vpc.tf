resource "aws_vpc" "nfs_vpc" {
  cidr_block = var.nfs_vpc
  enable_dns_hostnames = true

  tags = {
      Name = "EFS-Mount-Demo"
  }
}