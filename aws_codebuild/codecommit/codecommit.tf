resource "aws_codecommit_repository" "repo" {
  repository_name = var.repository_name
  description = "CodeCommit Terraform repo for demo"

}

output "terraform_codecommit_repo_arn" {
  value = aws_codecommit_repository.repo.arn
}

output "terrafrom_codecommit_repo_name" {
  value = var.repository_name
}