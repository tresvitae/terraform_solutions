resource "aws_codepipeline" "project-pipeline" {
  name = "${var.project_name}-pipeline"  
  role_arn = aws_iam_role.codepipeline-role.arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"

    encryption_key {
      id   = aws_kms_alias.artifacts.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = 1
      output_artifacts = ["docker-source"]
      
      configuration = {
        RepositoryName = aws_codecommit_repository.myapp.repository_name
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["docker-source"]
      output_artifacts = ["docker-build"]
      version          = 1

      configuration = {
        ProjectName = aws_codebuild_project.docker-build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployToECS"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["docker-build"]
      version         = 1

      configuration = {
        ApplicationName                = aws_codedeploy_app.docker-deploy.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.dg-ecsallatonce.deployment_group_name
        TaskDefinitionTemplateArtifact = "docker-build"
        AppSpecTemplateArtifact        = "docker-build"
      }
    }
  
  }
}