resource "aws_subnet" "nfs_subnet" {
  cidr_block = var.nfs_sub
  vpc_id = aws_vpc.nfs_vpc.id

  tags = {
      Name = "EFS-Mount-Demo"
  }
}