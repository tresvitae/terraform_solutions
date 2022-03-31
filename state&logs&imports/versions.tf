terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.6"
    }
  }
  required_version = ">= 1.1.5"
}