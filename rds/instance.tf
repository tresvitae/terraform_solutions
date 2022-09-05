data "aws_key_pair" "softserve" {
  key_name = var.PUBLIC_KEY
}

resource "aws_instance" "db_bastion" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main_public_1.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = data.aws_key_pair.softserve.key_name
}