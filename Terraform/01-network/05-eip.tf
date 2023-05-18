resource "aws_eip" "elastic_IP" {
  vpc = true

  tags = {
      Name = "Custom Elastic IP"
  }
}