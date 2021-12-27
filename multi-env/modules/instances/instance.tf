variable "ENV" {
}
variable "INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "PUBLIC_KEY" {
  default = "softserve"
}
variable "PUBLIC_SUBNETS" {
  type = list
}
variable "VPC_ID" {
}

data "aws_key_pair" "softserve" {
    key_name = var.PUBLIC_KEY
}

data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.INSTANCE_TYPE
  subnet_id              = element(var.PUBLIC_SUBNETS, 0)
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = data.aws_key_pair.softserve.key_name
  
  tags = {
      Environment = var.ENV
  }
}

resource "aws_security_group" "allow-ssh" {
  vpc_id = var.VPC_ID
  name = "allow-ssh--${var.ENV}"
  description = "SG allow ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environmnent = var.ENV
  }
}