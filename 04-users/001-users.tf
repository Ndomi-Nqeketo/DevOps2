resource "aws_iam_user" "john" {
  name = "john"

  tags = {
    Group = var.developers
  }
}

resource "aws_iam_user" "thabo" {
  name = "thabo"

  tags = {
    Group = var.developers
  }
}

resource "aws_iam_user" "tom" {
  name = "tom"

  tags = {
    Group = var.operations
  }
}

resource "aws_iam_user" "jerry" {
  name = "jerry"

  tags = {
    Group = var.operations
  }
}

resource "aws_iam_user" "boy" {
    name = "boy"
    tags = {
        Group = var.devops
    }
}

resource "aws_iam_user" "tim" {
    name = "tim"

    tags = {
        Group = var.devops
    }
}

resource "aws_iam_user" "marry" {
  name = "marry"

  tags = {
    Group = var.testers
  }
}

resource "aws_iam_user" "lucas" {
  name = "lucas"

  tags = {
    Group = var.testers
  }
}