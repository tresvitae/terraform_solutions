resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main_public_1.id
  depends_on    = [aws_internet_gateway.main_gw]
}

resource "aws_route_table" "main_private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_route_table_association" "main_private_1_a" {
  subnet_id      = aws_subnet.main_private_1.id
  route_table_id = aws_route_table.main_private.id
}
resource "aws_route_table_association" "main_private_2_a" {
  subnet_id      = aws_subnet.main_private_2.id
  route_table_id = aws_route_table.main_private.id
}