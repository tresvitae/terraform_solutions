data "aws_key_pair" "softserve" {
    key_name = var.PUBLIC_KEY
}

resource "aws_instance" "example" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = data.aws_key_pair.softserve.key_name
  user_data              = data.cloudinit_config.cloudinit-example.rendered

  root_block_device {
    volume_size           = 17
    volume_type           = "gp2"
    delete_on_termination = true
  }

  provisioner "file" {
    source      = "scripts/nginx.sh"
    destination = "/tmp/nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo sed -i -e 's/\r$//' /tmp/nginx.sh",  # Remove the spurious CR characters.
      "sudo /tmp/nginx.sh",
    ]
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file("${var.PUBLIC_KEY}.pem")
  }
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "${var.AWS_REGION}a"
  size              = 21
  type              = "gp2"

  tags = {
    ProjectName = var.project_name
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = var.INSTANCE_DEVICE_NAME
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
  #skip_destroy = true
}