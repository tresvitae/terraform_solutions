resource "aws_codebuild_project" "docker-build" {
  name           = "docker-build"
  description    = "Docker compose build images"
  build_timeout  = 30
  service_role   = aws_iam_role.codebuild-role.arn
  encryption_key = aws_kms_alias.artifacts.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  #cache {
    #type = "S3"
    #location = aws_s3_bucket.codebuild-cache.bucket
  #}

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.AWS_REGION
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = data.aws_ecr_repository.myapp.name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  #depends_on = [aws_s3_bucket.codebuild-cache]
}