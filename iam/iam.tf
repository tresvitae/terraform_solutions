resource "aws_iam_group" "administrators" {
  name = "Administrators"
}

resource "aws_iam_policy_attachment" "administrators-attach" {
  name       = "administrators-attach"
  groups     = [aws_iam_group.administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin" {
  name = "Admin"
}

resource "aws_iam_group_membership" "administrators-users" {
  name  = "administrators-users"
  users = [
      aws_iam_user.admin.name,
  ]
  group = aws_iam_group.administrators.name
}
