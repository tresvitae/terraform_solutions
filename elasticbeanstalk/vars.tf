variable "project_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "db_instance_type" {
  type = string
}
variable "AWS_REGION" {
  type = string
}

variable "PUBLIC_KEY" {
  type = string
  default = "softserve"
}

variable "RDS_USERNAME" {
  type = string
  default = "admin"
}

variable "RDS_PASSWORD" {
  type = string
}