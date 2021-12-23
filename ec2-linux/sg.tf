#Datasources
data "aws_ip_ranges" "european_ec2" {
  regions  = ["eu-west-1", "eu-west-2"]
  services = ["ec2"]
}

resource "aws_security_group" "from_europe" {
  name = "from_europe"
  
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.european_ec2.cidr_blocks, 0, 50)
  }

  tags = {
    CreateData = data.aws_ip_ranges.european_ec2.create_date
    SyncToke   = data.aws_ip_ranges.european_ec2.sync_token
  }
}






#!/bin/bash
#echo "database-ip = ${myip}" >> /etc/myapp.config

#Template provider. It's data-user in AWS Console
data "template_file" "my-template" {
template = "${file("templates/init.tpl")}"
vars {
myip = "${aws_instance.database1.private_ip}"
}
}

# Create a web server
resource "aws_instance" "web" {
# ...
user_data = "${data.template_file.my-template.rendered}"
}