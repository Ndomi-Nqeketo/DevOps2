terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "example.ndomi.state"
    dynamodb_table = "dynamodb-terraform-state-lock"
    region         = "us-east-1"
    key            = "deploy/terraform.tfstate"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  hash_key       = "LockID"
  name           = "terraform-state-lock-dynamo"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = " DynamoDB Terraform State Lock Table"
  }
}