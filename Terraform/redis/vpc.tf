resource "aws_vpc" "redis_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "${var.project}-${var.environment}-${var.name}-vpc"
  }
}