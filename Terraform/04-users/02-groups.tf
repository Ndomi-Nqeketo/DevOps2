resource "aws_iam_group" "operations" {
  name = var.operations
}

resource "aws_iam_group" "developers" {
  name = var.developers
}

resource "aws_iam_group" "testers" {
  name = var.testers
}

resource "aws_iam_group" "devops" {
    name = var.devops
}