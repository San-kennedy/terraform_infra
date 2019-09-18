# ----------------------------------------------------------------------------------------------
# Mandatory Variables
# ----------------------------------------------------------------------------------------------

variable "sg_name" {
  description = "Name of security group."
}

variable "sg_description" {
  description = "Description for SG."
}

variable "sg_vpc_id" {
  description = "VPC id to which SG belongs to."
}

variable "sg_modifyrule" {
  description = "Flag to modify rules for SG."
  default  = false
}

variable "sg_ingress_cidr_blocks" {
  description = "Cidr block to which the rule must be added."
  default = []
}

variable "sg_ingress_rules" {
  description = "List of rules from sg_rules that need to be applied to SG."
  default = []
}

variable "sg_rules" {
  description = "Map of rules with list of format [fromport, toport, protocol, description]"
  default = {}
}