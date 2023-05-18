resource "aws_route_table" "custom_RT" {
  vpc_id = aws_vpc.main_vpc.id

  route {
      cidr_block = var.internet_ip
      gateway_id = aws_internet_gateway.IGW-TF.id
  }

  tags = {
      Name = "Custom RT"
  }

  depends_on = [aws_vpc.main_vpc, aws_internet_gateway.IGW-TF]
}