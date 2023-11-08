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

# Vault Server IAM Config
resource "aws_iam_instance_profile" "vault-server" {
  name = "${var.environment_name}-vault-server-instance-profile"
  role = aws_iam_role.vault-server.name
}

resource "aws_iam_role" "vault-server" {
  name               = "${var.environment_name}-vault-server-role"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy" "vault-server" {
  name   = "${var.environment_name}-vault-server-role-policy"
  role   = aws_iam_role.vault-server.id
  policy = data.aws_iam_policy_document.vault-server.json
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
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "vault-server" {
  statement {
    sid       = "1"
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }

  statement {
    sid    = "VaultAWSAuthMethod"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "iam:GetInstanceProfile",
      "iam:GetUser",
      "iam:GetRole"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "EnableKMSForVaultAutoUnsealAndKMSForRaftSnapshotsForS3"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
  }
}