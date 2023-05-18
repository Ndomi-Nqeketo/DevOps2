resource "aws_security_group" "nfs-sg" {
  vpc_id = aws_vpc.nfs_vpc.id
  description = "EFS-EC2 Access Security Group"

  tags = {
      name = "EFS-Mount-Demo"
  }
}

resource "aws_security_group_rule" "nfs-sg-rule-ingress" {
  description = "Ingress rule to allow traffic to EFS"
  from_port = 2049
  to_port = 2049
  protocol = "tcp"
  security_group_id = aws_security_group.nfs-sg.id
  type = "ingress"
  self = true
}

resource "aws_security_group_rule" "nfs-sg-rule-egress" {
  description       = "Egress rule to to allow traffic from instances to EFS"
  from_port = 2049
  to_port = 2049
  protocol = "tcp"
  security_group_id = aws_security_group.nfs-sg.id
  type = "egress"
  self = true
}