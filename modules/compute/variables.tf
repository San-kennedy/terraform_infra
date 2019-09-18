# ----------------------------------------------------------------------------------------------
# Mandatory Variables
# ----------------------------------------------------------------------------------------------

variable "service_name" {
  description = "Name of the service deployed on the host, will be added as part of hostname"
}

variable "hostname_prefix" {
  description = "Hostname prefix specifying env, cloud and team"
}

variable "instance_role"{
  description = "Role that the VM is setup for"
}

variable "instance_subnet" {
  description = "List of subnet_id that the machines should be created in(specified inorder) - defaults to vsw-k1ac7v8g14yn2bxcl2tyj (prod-private-a)"
  type        = "list"
}

# ----------------------------------------------------------------------------------------------
# Optional Variables
# ----------------------------------------------------------------------------------------------

variable "instance_sg"{
  description= "SG the Instance needs to be added to"
  default = []
}

variable "instance_public_ip"{
  description= "Flag to set public_ip"
  default = false
}

variable "instance_type" {
  description = "List of instance types in order - defaults"
  default = "t3.micro"
}

variable "boot_disk_size" {
  description = "The size of the boot_disk in gigabytes"
  default = 20
}

variable "boot_disk_type" {
  description = "The type of the boot_disk, pd-standard or pd-ssd"
  default = "standard"
}

variable "boot_disk_image" {
  description = "The image from which to initialize the root disk"
  default = ""
}

variable "instance_count" {
  description = "Number of instances required"
  default = 1
}

variable "instance_hostname" {
  description = "Hostname, if automated hostname does not suit the need"
  default = ""
}

variable "instance_deploykey" {
  description = "Key pair to be used for deployment"
}

variable "instance_ip" {
  description = "List of IPs that need to be assigned in order - Leave it empty to assign dynamically"
  type        = "list"
  default = []
}
