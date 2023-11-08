# Vault Client IAM Config
resource "aws_iam_instance_profile" "vault-transit" {
  name = "${var.environment_name}-vault-transit-instance-profile"
  role = aws_iam_role.vault-transit.name
}

resource "aws_iam_role" "vault-transit" {
  name               = "${var.environment_name}-vault-transit-role"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy" "vault-transit" {
  name   = "${var.environment_name}-vault-transit-role-policy"
  role   = aws_iam_role.vault-transit.id
  policy = data.aws_iam_policy_document.vault-transit.json
}

// Data Sources
data "aws_iam_policy_document" "assume-role" {
  statement {
    effect  = "Allow"
    actions = ["sts.AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "vault-transit" {
  statement {
    sid       = "1"
    effect     = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
}