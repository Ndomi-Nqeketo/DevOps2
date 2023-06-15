variable "codebuild_project_terraform_plan_name" {
  description = "Name for CodeBuild Terraform Plan Project"
  # default = "project_plan_name"
}
variable "codebuild_project_terraform_apply_name" {
  description = "Name for CodeBuild Terraform Apply Project"
  # default = "project_apply_name"
}
variable "s3_logging_bucket_id" {
  description = "ID of the S3 bucket for access logging"
  # default = "logging-bucket-id20230614"
}
variable "s3_logging_bucket" {
  description = "Name of the S3 bucket for access logging"
  # default = "logging-bucket20230614"
}
variable "codebuild_iam_role_arn" {
  description = "ARN of the CodeBuild IAM role"
  # default = ""
}