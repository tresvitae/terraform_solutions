variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    eu-west-2 = "ami-0015a39e4b7c0966f" # Ubuntu Server 20.04 LTS (HVM)
    eu-west-1 = "ami-08ca3fed11864d6bb" # Ubuntu Server 20.04 LTS (HVM)
  }
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "PUBLIC_KEY" {
  default = "softserve"
}
