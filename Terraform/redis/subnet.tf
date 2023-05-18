resource "aws_subnet" "private_1" {
#    count = var.availability_zones_count

  vpc_id            = aws_vpc.redis_vpc.id
  cidr_block        = "10.1.0.0/28"
  availability_zone = var.az_1

  tags = {
    Name = "${var.project}-${var.environment}-${var.name}-private_subnet_1"
  }
}

resource "aws_subnet" "private_2" {
#    count = var.availability_zones_count

  vpc_id            = aws_vpc.redis_vpc.id
  cidr_block        = "10.1.0.16/28"
  availability_zone = var.az_2

  tags = {
    Name = "${var.project}-${var.environment}-${var.name}-private_subnet_2"
  }
}