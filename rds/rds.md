# RDS connect using EC2

## install db clinet
```bash
apt-get update
apt install mysql-client -y
apt-get install mariadb-client -y
```

## Connect to DB
` mysql -h mariadb.ckohgkzaheog.eu-west-1.rds.amazonaws.com -P 3306 -u root -p `