resource "aws_codecommit_repository" "myapp" {
  repository_name = "myapp"
  description     = "${var.project_name} repository"
}