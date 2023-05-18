resource "aws_security_group" "vpc-ssh" {
  name = "vpc-ssh"
  description = "Allow SSH traffic"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
      description = "Allow SSH traffic Inbound"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      description = "Allow outbound traffic"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "Allow SSH Traffic"
  }
}

resource "aws_security_group" "web-traffic" {
  name = "vpc-web"
  description = "Allow WEB traffic"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
      description = "Allow WEB traffic Inbound"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      description = "Allow Secure WEB traffic Inbound"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      description = "Allow outbound traffic"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "Allow WEB Traffic"
  }
}