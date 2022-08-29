variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "INSTANCE_USERNAME" {
  default = "Patryk"
}

variable "INSTANCE_PASSWORD" {
}

variable "PUBLIC_KEY" {
  default = "softserve"
}

# Note: WIN_AMIS is now Replaced by ami.tf
#variable "WIN_AMIS" {
#  type = map(string)
#  default = {
#    us-east-1 = "ami-30540427"
#    us-west-2 = "ami-9f5efbff"
#    eu-west-1 = "ami-7ac78809"
#  }
#}