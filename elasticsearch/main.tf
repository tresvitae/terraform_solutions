module "security" {
  source = "./modules/security"

  tags = var.tags
}

module "elasticsearch" {
  source = "./modules/elasticsearch"

  aws_region = var.aws_region
  tags       = var.tags

  # Security
  my_public_ip          = var.my_public_ip
  encryption_kms_key_id = module.security.elasticsearch_kms_key_id

  # Elasticsearch
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version
  instance_type         = var.instance_type
  volume_size           = var.volume_size
}