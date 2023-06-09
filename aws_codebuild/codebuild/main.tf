resource "aws_codebuild_project" "codebuild_project_terraform_plan" {
  name         = var.codebuild_project_terraform_plan_name
  description = "Terraform codebuild project"
  build_timeout = "50"
  service_role = var.codebuild_iam_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type = "S3"
    location = var.s3_logging_bucket
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "1.5.0"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status = "ENABLED"
      location = "${var.s3_logging_bucket_id}/${var.codebuild_project_terraform_plan_name}/build-log"
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec-plan.yml"
  }

  tags = {
    Terraform = "true"
  }
}

output "codebuild_terraform_plan_name" {
  value = var.codebuild_project_terraform_plan_name
}

resource "aws_codebuild_project" "codebuild_project_terraform_apply" {
  name = var.codebuild_project_terraform_apply_name
  description = "Terraform codebuild project"
  build_timeout = "50"
  service_role = var.codebuild_iam_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type = "S3"
    location = var.s3_logging_bucket
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:5.0"
    type = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name = "TERRAFORM_VERSION"
      value = "1.5.0"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status = "ENABLED"
      location = "${var.s3_logging_bucket_id}/${var.codebuild_project_terraform_apply_name}/build-log"
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec-apply.yml"
  }

  tags = {
    Terrafrom = "true"
  }
}

output "codebuild_terraform_apply_name" {
  value = var.codebuild_project_terraform_apply_name
}