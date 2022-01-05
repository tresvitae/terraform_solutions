resource "aws_iam_role" "codedeploy-role" {
  name               = "codedeploy"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

data "aws_iam_policy_document" "codedeploy-role-polcy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:CreateTaskSet",
      "ecs:UpdateServicePrimaryTaskSet",
      "ecs:DeleteTaskSet",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:ModifyRule",
      "lambda:InvokeFunction",
      "cloudwatch:DescribeAlarms",
      "sns:Publish",
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
    ]
    resources = [
      "${aws_s3_bucket.artifacts.arn}/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:DescribeKey",
      "kms:Decrypt",
    ]
    resources = [
      aws_kms_key.artifacts.arn
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      aws_iam_role.ecs-task-execution-role.arn,
      aws_iam_role.ecs-task-role.arn,
    ]
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "codedeploy-role-policy" {
  name   = "codedeploy-role-policy"
  role   = aws_iam_role.codedeploy-role.id
  policy = data.aws_iam_policy_document.codedeploy-role-polcy.json
}