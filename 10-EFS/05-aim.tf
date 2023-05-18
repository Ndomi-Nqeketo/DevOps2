resource "aws_efs_file_system" "file-system" {
  creation_token = "some-token"
  encrypted = true
}

resource "aws_efs_mount_target" "efs" {
  file_system_id = aws_efs_file_system.file-system.id
  subnet_id = aws_subnet.nfs_subnet.id
  security_groups = [aws_security_group.nfs-sg.id]
}

resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.file-system.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "ExamplePolicy01",
    "Statement": [
        {
            "Sid": "ExampleSatement01",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${aws_efs_file_system.file-system.arn}",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
POLICY  
}