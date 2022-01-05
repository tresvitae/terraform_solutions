# ECR image
data "aws_ecr_repository" "myapp" {
  name = "myapp"
}

resource "aws_ecs_task_definition" "ecs-task" {
  family = "ecs-task"
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs-task-role.arn
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]

  container_definitions = <<DEFINITION
[
  {
    "essential": true,
    "image": "${data.aws_ecr_repository.myapp.repository_url}",
    "name": "myapp",
    "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
               "awslogs-group" : "myapp-logs",
               "awslogs-region": "${var.AWS_REGION}",
               "awslogs-stream-prefix": "ecs"
            }
     },
     "secrets": [],
     "environment": [],
     "healthCheck": {
       "command": [ "CMD-SHELL", "curl -f http://localhost:3000/ || exit 1" ],
       "interval": 30,
       "retries": 3,
       "timeout": 5
     }, 
     "portMappings": [
        {
           "containerPort": 3000,
           "hostPort": 3000,
           "protocol": "tcp"
        }
     ]
  }
]
DEFINITION

}

resource "aws_ecs_service" "service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.cluster.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.ecs-task.arn
  launch_type     = "FARGATE"
  depends_on      = [aws_lb_listener.nlb-listener]

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = slice(module.vpc.public_subnets, 1, 2)
    security_groups  = [aws_security_group.ecs-sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg-blue.id
    container_name   = "myapp"
    container_port   = "3000"
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]
  }
}

resource "aws_security_group" "ecs-sg" {
  name   = "ECS SG"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Logs
resource "aws_cloudwatch_log_group" "myapp-logs" {
  name = "myapp-logs"
}