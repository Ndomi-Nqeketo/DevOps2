resource "aws_iam_role" "ssm_role" {
  name               = "ssm-ec2"
  assume_role_policy = file("${path.module}/iam_policy.json")
}

# Instance Profile
resource "aws_iam_instance_profile" "profile" {
  name = "ssm-ec2"
  role = aws_iam_role.ssm_role.name
}

# Attach Policies to Instance Role
resource "aws_iam_policy_attachment" "attach1" {
  name = "attachment1"
  roles = [aws_iam_role.ssm_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy_attachment" "attach2" {
  name = "attachment2"
  roles = [aws_iam_role.ssm_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

# Attach Policies to Instance Role
resource "aws_iam_policy_attachment" "attach3" {
  name = "attachment3"
  roles = [aws_iam_role.ssm_role.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}