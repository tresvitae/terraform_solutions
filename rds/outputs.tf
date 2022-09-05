output "instance" {
  value = aws_instance.db_bastion.public_ip
}

output "rds" {
  value = aws_db_instance.mariadb.endpoint
}