variable "my_public_ip" {
  default     = "0.0.0.0/0"
  description = "For security reason, the Elasticsearch instance will be limited to your external IP"
  type        = string
}

variable "project_name" {
  default = "MyElasticSearch"
}

variable "aws_region" {
  description = "Region where the Elasticsearch instance will be deployed"
  default     = "eu-west-1"
}

variable "domain_name" {
  default     = "elasticsearch-single-node"
  description = "Elastic Search Service cluster name."
  type        = string
}

variable "elasticsearch_version" {
  default     = "6.8"
  description = "Elastic Search Service cluster version number."
  type        = string
}

variable "instance_type" {
  default     = "m4.large.elasticsearch"
  description = "Elastic Search Service cluster Ec2 instance type. The t2 family doesn't supports encryption at rest"
  type        = string
}

variable "volume_size" {
  default     = "10"
  description = "Default size of the EBS volumes."
  type        = string
}

variable "tags" {
  description = "Default tags to apply to all the resources"
  type        = map(string)

  default = {
    Terraform = "true"
  }
}