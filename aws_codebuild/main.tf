terraform {
  required_version = ">=0.12.16"
}

provider "aws" {
  region = "us-east-1"
}

module "bootstrap" {
  source = "./bootstrap"
  s3_tfstate_bucket = "tfstate20230614"
  s3_logging_bucket_name = "loggingbucket20230614"
  dynamo_db_table_name = "dynamo20230614"
  codebuild_iam_role_name             = "CodeBuildIamRole"
  codebuild_iam_role_policy_name      = "CodeBuildIamRolePolicy"
  terraform_codecommit_repo_arn       = module.codecommit.terraform_codecommit_repo_arn
  tf_codepipeline_artifact_bucket_arn = module.codepipeline.tf_codepipeline_artifact_bucket_arn
}

module "codecommit" {
  source = "./codecommit"
  repository_name = "CodeCommitTerraform"
}

module "codebuild" {
  source = "./codebuild"
  codebuild_project_terraform_plan_name = "TerraformPlan"
  codebuild_project_terraform_apply_name = "TerraformApply"
  s3_logging_bucket_id = module.bootstrap.s3_logging_bucket_id
  codebuild_iam_role_arn = module.bootstrap.codebuild_iam_role_arn
  s3_logging_bucket = module.bootstrap.s3_logging_bucket
}

module "codepipeline" {
  source = "./codepipeline"
  tf_codepipeline_name = "TerraformCodePipeline"
  tf_codepipeline_artifact_bucket_name = "codebuild-demo-artifact-bucket-name20230614"
  tf_codepipeline_role_name = "TerraformCodePipelineIamRole"
  tf_codepipeline_role_policy_name = "TerraformCodePipelineIamRolePolicy"
  terraform_codecommit_repo_name = module.codecommit.terrafrom_codecommit_repo_name
  codebuild_terraform_plan_name = module.codebuild.codebuild_terraform_plan_name
  codebuild_terraform_apply_name = module.codebuild.codebuild_terraform_apply_name
}