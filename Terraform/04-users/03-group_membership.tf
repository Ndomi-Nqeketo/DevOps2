resource "aws_iam_group_membership" "developers" {
  group = aws_iam_group.developers.name
  name = "Developers"
  users = [
      aws_iam_user.john.name,
      aws_iam_user.thabo.name
  ]
}

resource "aws_iam_group_membership" "operations" {
  group = aws_iam_group.operations.name
  name = "Operations"
  users = [ 
      aws_iam_user.tom.name,
      aws_iam_user.jerry.name    
  ]
}

resource "aws_iam_group_membership" "devops" {
    group = aws_iam_group.devops.name
    name = "DevOps"
    users = [
        aws_iam_user.boy.name,
        aws_iam_user.tim.name
    ]
}

resource "aws_iam_group_membership" "testers" {
  group = aws_iam_group.testers.name
  name  = "Testers"
  users = [
    aws_iam_user.lucas.name,
    aws_iam_user.marry.name
  ]
}