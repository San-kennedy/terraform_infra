# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "The region in which all aws resources will be launched."
  default = "us-west-1"
}

variable "cred_file"{
  description = "File with user creds for the aws project where resources will be launched"
  default = "./deploy_creds"
}

variable "publickey"{
  description = "Public key string used for deployment keypair"
}