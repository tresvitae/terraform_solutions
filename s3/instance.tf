data "aws_key_pair" "softserve" {
    key_name = var.PUBLIC_KEY
}

resource "aws_instance" "example" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = data.aws_key_pair.softserve.key_name
  iam_instance_profile   = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name
}
