resource "aws_subnet" "custom_subnet" {
  cidr_block = var.subnet_cidr
  vpc_id = aws_vpc.main_vpc.id

  availability_zone = var.az
  map_public_ip_on_launch = true

  tags = {
      Name = "Custom subnet"
  }
}