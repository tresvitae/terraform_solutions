variable "project_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "AWS_REGION" {
  type = string
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "PUBLIC_KEY" {
  default = "softserve"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}