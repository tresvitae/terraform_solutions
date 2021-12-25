resource "aws_s3_bucket" "s3-bucket" {
  bucket = "mybucket-tresvitae"
  acl    = "private"

  tags = {
    Name        = "mybucket-tresvitae"
    ProjectName = var.project_name
  }
}

