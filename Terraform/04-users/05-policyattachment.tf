resource "aws_iam_policy_attachment" "dev_policy" {
  name       = "dev_policy"
  policy_arn = aws_iam_policy.developers.arn
  roles      = [aws_iam_role.ec2_role.name]
  groups     = [aws_iam_group.developers.name]
  depends_on = [aws_iam_policy.developers]
}

resource "aws_iam_policy_attachment" "devops_policy" {
    name = "ops_policy"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    groups = [aws_iam_group.devops.name]
}

resource "aws_iam_policy_attachment" "ops_policy" {
  name       = "ops_policy"
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  groups     = [aws_iam_group.operations.name]
}

resource "aws_iam_policy_attachment" "testers_policy" {
  name       = "testers_policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  groups     = [aws_iam_group.testers.name]
}