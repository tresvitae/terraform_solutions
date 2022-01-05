# Cache
resource "aws_s3_bucket" "codebuild-cache" {
  bucket = "codebuild-cache-${random_string.random.result}"
  acl    = "private"
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "artifacts-${random_string.random.result}"
  acl    = "private"

  lifecycle_rule {
    id      = "clean-up"
    enabled = true

    expiration {
      days = 30
    }
  }
}

resource "random_string" "random" {
  length  = 1
  special = false
  upper   = false
}