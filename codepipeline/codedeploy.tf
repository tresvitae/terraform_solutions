resource "aws_codedeploy_app" "docker-deploy" {
  compute_platform = "ECS"
  name             = "docker-deploy"
}

resource "aws_codedeploy_deployment_group" "dg-ecsallatonce" {
  app_name      = aws_codedeploy_app.docker-deploy.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "app-group"
  service_role_arn       = aws_iam_role.codedeploy-role.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style { 
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.cluster.name
    service_name = aws_ecs_service.service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.nlb-listener.arn]
      }

      target_group {
        name = aws_lb_target_group.tg-blue.name
      }

      target_group {
        name = aws_lb_target_group.tg-green.name
      }
    }
  }
}