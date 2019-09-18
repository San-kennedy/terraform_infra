# ----------------------------------------------------------------------------------------------
# Mandatory Variables
# ----------------------------------------------------------------------------------------------

variable "network_aws_region" {
  description = "The region in which all aws resources will be launched."
  default = "us-west-1"
}

variable "network_aws_zone" {
  description = "The region in which all aws resources will be launched."
  default = "a"
}

variable "network_vpc_id" {
  description = "VPC id"
}
variable "network_gw_id" {
  description = "Internet gateway id"
}
variable "vpc_cidrblock" {
  description = "CIDR range for vpc."
  default = "10.0.0.0/23"
}

variable "private_cidrblock" {
  description = "CIDR range for vpc."
  default = "10.0.1.0/24"
}

variable "public_cidrblock" {
  description = "CIDR range for vpc."
  default = "10.0.0.0/24"
}

