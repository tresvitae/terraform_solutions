resource "aws_db_subnet_group" "mariadb-subnet" {
  name = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}

resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "mariadb-parameters"
  family      = "mariadb10.4"
  description = "MariaDB parameter group"
}

resource "aws_db_instance" "mariadb" {
  allocated_storage       = 100
  engine                  = "mariadb"
  engine_version          = "10.4.13"
  instance_class          = var.db_instance_type
  identifier              = "mariadb"
  name                    = "mariadb"
  username                = var.RDS_USERNAME
  password                = var.RDS_PASSWORD
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name    = aws_db_parameter_group.mariadb-parameters.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30
  availability_zone       = aws_subnet.main-private-1.availability_zone
  skip_final_snapshot     = true

  tags = {
    ProjectName = var.project_name
  }
}