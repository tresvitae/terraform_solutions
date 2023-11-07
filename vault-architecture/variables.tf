# AWS EC2 Region
variable "aws_region" {
  default = "eu-west-1"
}

# AWS EC2 Availability Zone
variable "availability_zones" {
  default = "eu-west-1a"
}

# AWS EC2 Key Pair
# @see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
# SSH key name to access EC2 instances (should already exist) in the AWS Region
variable "master-vault-key" {
}

# Specify a name here to tag all instances
variable "environment_name" {
  default = "dev"
}
