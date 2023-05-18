resource "aws_vpc" "ecs-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "ecs-vpc"
  }
}