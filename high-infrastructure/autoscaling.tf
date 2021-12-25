data "aws_key_pair" "softserve" {
    key_name = var.PUBLIC_KEY
}

resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = var.instance_type
  key_name        = data.aws_key_pair.softserve.key_name
  security_groups = [aws_security_group.instance-sg.id]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho '> '$MYIP > /var/www/html/index.html"
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id, aws_subnet.main-public-3.id]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  force_delete              = true
  #health_check_type         = "EC2"
  # Classic Load Balancer
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.clb.name]
}