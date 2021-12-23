data "aws_key_pair" "softserve" {
    key_name = var.PUBLIC_KEY
}

resource "aws_instance" "ubuntu" {
  ami                         = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.softserve.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2-ubuntu-sg.name]
  #subnet_id = 

  # Execute script forms
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  # remote-exec + connection
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
      "sudo /tmp/script.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip) # self.public_ip
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file("${var.PUBLIC_KEY}.pem")
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.ubuntu.private_ip} > data.txt"
  }
}

data "external" "public-ip" {
  program = ["sh", "publicip.sh"]
}

resource "aws_security_group" "ec2-ubuntu-sg" {
  name        = "Nginx website access with ssh open"
  description = "Traffic connection to EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.public-ip.result.ip}/32"]
    description = "Access to EC2, only my IP address"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open to World, run Nginx"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Open to World"
  }
}






