resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  tags = {
    ProjectName = var.project_name
  }
}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_subnet" "main-public-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_subnet" "main-private-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-3-a" {
  subnet_id      = aws_subnet.main-public-3.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = aws_subnet.main-private-2.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "main-private-3-a" {
  subnet_id      = aws_subnet.main-private-3.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-public-1.id
  depends_on    = [aws_internet_gateway.main-gw]
}