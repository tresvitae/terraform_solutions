terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.7"
    }
    template = {
      version = "~> 2.1"
    }
    null = {
      version = "~> 2.1"
    }
  }
}

provider "aws" {
  profile = "terraform"
  region  = var.aws_region
}