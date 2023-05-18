resource "aws_route_table_association" "custom_RT_association" {
  route_table_id = aws_route_table.custom_RT.id
  subnet_id = aws_subnet.custom_subnet.id
  depends_on = [aws_subnet.custom_subnet, aws_route_table.custom_RT]
}