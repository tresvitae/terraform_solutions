source: https://github.com/timoa/terraform-elasticsearch-single-node

- Create an AWS Elasticsearch Service instance (managed by AWS)
- Encryption with a KMS CMK (let you manage the usage of the KMS key)
- Accessible only from your public IP
- Deploy the Elasticsearch instance under your default VPC 


Need to set your public ip address in module security in main.tf file:
my_public_ip          = var.my_public_ip