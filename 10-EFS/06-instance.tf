data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

resource "aws_iam_role" "ec2-role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2-role-policy" {
  role = aws_iam_role.ec2-role.id
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite"
        ],
        "Effect": "Allow",
        "Resource": "${aws_efs_file_system.file-system.arn}"
      }
    ]
  }
  EOF
}

resource "aws_iam_instance_profile" "ec2-profile" {
  role = aws_iam_role.ec2-role.name
}

data "template_file" "init" {
  template = file("${path.module}/bootstrap.sh")
  vars = {
      fs_id = aws_efs_mount_target.efs.file_system_id
  }
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  user_data = data.template_file.init.rendered
  vpc_security_group_ids = [aws_security_group.nfs-sg.id]
  subnet_id = aws_subnet.nfs_subnet.id

  tags = {
      Name = "EFS-Mount-Demo"
  }
}