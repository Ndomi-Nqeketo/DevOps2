variable "s3_tfstate_bucket" {
  description = "Name of the S3 bucket used for Terraform state storage"
#   default = "tfstate20230614"
}
variable "s3_logging_bucket_name" {
  description = "Name of S3 bucket to use for access logging"
#   default = "loggingbucket20230614"
}
variable "dynamo_db_table_name" {
  description = "Name of DynamoDB table used for Terraform locking"
#   default = "dynamo20230614"
}
variable "codebuild_iam_role_name" {
  description = "Name for IAM Role utilized by CodeBuild"
#   default = "codebuild-role20230614"
}
variable "codebuild_iam_role_policy_name" {
  description = "Name for IAM policy used by CodeBuild"
#   default = "codebuild-policy20230614"
}
variable "terraform_codecommit_repo_arn" {
  description = "Terraform CodeCommit git repo ARN"
#   default = "arn:aws:codecommit:us-east-1:225908212644:codecommit-repo"
}
variable "tf_codepipeline_artifact_bucket_arn" {
  description = "Codepipeline artifact bucket ARN"
#   default = "copebuild-pipeline20230614"
}