terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.69.0"
    }
  }
}

provider "aws" {
  profile = "terraform"
  region  = "eu-west-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_s3_bucket" "example" {
  acl    = "private"
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  depends_on = [aws_s3_bucket.example]
}

module "example_sqs_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "2.1.0"

  depends_on = [aws_s3_bucket.example, aws_instance.example]
}

