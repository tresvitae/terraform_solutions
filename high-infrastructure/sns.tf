resource "aws_sns_topic" "topic" {
  name         = "sg-topic"
  display_name = "example ASG SNS topic"
}

resource "aws_sns_topic_subscription" "subscribers" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "patryk.futa@gmail.com"
}

resource "aws_autoscaling_notification" "example-notify" {
  group_names    = [aws_autoscaling_group.example-autoscaling.name]
  topic_arn      = aws_sns_topic.topic.arn
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
}
