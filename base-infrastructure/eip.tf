resource "aws_eip" "ec2-eip" {
  instance = aws_instance.example.id
  vpc      = true
  depends_on    = [aws_internet_gateway.main-gw]
}