resource "aws_route53_zone" "tresvitae-tk" {
  name = "tresvitae.tk"
}

resource "aws_route53_record" "server1-record" {
  zone_id = aws_route53_zone.tresvitae-tk.zone_id
  name    = "server1.tresvitae.tk"
  type    = "A"
  ttl     = 300
  records = [aws_eip.ec2-eip.public_ip]
}

resource "aws_route53_record" "www-record" {
  zone_id = aws_route53_zone.tresvitae-tk.zone_id
  name    = "www.tresvitae.tk"
  type    = "A"
  ttl     = 300
  records = [aws_eip.ec2-eip.public_ip]
}

# Overwrite NS records to allow managing these records
resource "aws_route53_record" "ns-record" {
  allow_overwrite = true
  zone_id         = aws_route53_zone.tresvitae-tk.zone_id
  name            = "tresvitae.tk"
  type            = "NS"
  ttl             = 172800

  records = [
    aws_route53_zone.tresvitae-tk.name_servers[0],
    aws_route53_zone.tresvitae-tk.name_servers[1],
    aws_route53_zone.tresvitae-tk.name_servers[2],
    aws_route53_zone.tresvitae-tk.name_servers[3],
  ]
}