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
variable "vault_key_name" {
  default = "X"
}

# Specify a name here to tag all instances
variable "environment_name" {
  default = "dev"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vault_transit_private_ip" {
  description = "The private IP of the first Vault node for Auto Unsealing"
  default     = "10.0.101.21"
}

# URL for Vault OSS binary
variable "vault_zip_file" {
  default = "https://releases.hashicorp.com/vault/1.15.1/vault_1.15.1_linux_amd64.zip"
}

variable "vault_server_names" {
  description = "Names of the Vault nodes that will join the cluster"
  type        = list(string)
  default     = ["vault_2", "vault_3", "vault_4"]
}

variable "vault_server_private_ips" {
  description = "The private IPs of the Vault nodes that will join the cluster"
  type        = list(string)
  default     = ["10.0.101.22", "10.0.101.23", "10.0.101.24"]
}
