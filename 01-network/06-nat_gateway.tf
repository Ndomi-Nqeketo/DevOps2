resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.elastic_IP.id
  subnet_id = aws_subnet.custom_subnet.id

  tags = {
      Name = "Custom natgateway"
  }

  depends_on = [aws_vpc.main_vpc, aws_eip.elastic_IP]
}