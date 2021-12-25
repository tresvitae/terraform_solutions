resource "aws_security_group" "instance-sg" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "SG allows ssh and all egress traffic and forward 80 to CLB"
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

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.clb-securitygroup.id]
  }

  tags = {
    Name        = "instance-sg"
    ProjectName = var.project_name
  }
}

resource "aws_security_group" "clb-securitygroup" {
  vpc_id      = aws_vpc.main.id
  name        = "clb"
  description = "SG for load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "clb"
    ProjectName = var.project_name
  }
}