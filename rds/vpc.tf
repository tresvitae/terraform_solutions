resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_subnet" "main_public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    ProjectName = var.project_name
  }
}
resource "aws_subnet" "main_public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.AWS_REGION}b"
  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_subnet" "main_private_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    ProjectName = var.project_name
  }
}
resource "aws_subnet" "main_private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.12.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_route_table" "main_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_route_table_association" "main_public_1_a" {
  subnet_id      = aws_subnet.main_public_1.id
  route_table_id = aws_route_table.main_public.id
}
resource "aws_route_table_association" "main_public_2_a" {
  subnet_id      = aws_subnet.main_public_2.id
  route_table_id = aws_route_table.main_public.id
}