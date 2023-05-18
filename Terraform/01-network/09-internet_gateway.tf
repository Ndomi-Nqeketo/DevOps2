resource "aws_internet_gateway" "IGW-TF" {
  vpc_id = aws_vpc.main_vpc.id

  depends_on = [aws_vpc.main_vpc]
}