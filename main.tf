provider "aws" {
  shared_credentials_file = "${var.cred_file}"
  profile                 = "default"
  region                  = "${var.aws_region}"
}

#Setiing up VPC
resource "aws_vpc" "play_network" {
  cidr_block = "10.0.0.0/22"
  tags = {
    Name = "Play"
  }
}

#Setting up an internet gate way for vpc
resource "aws_internet_gateway" "play_gw" {
  vpc_id = "${aws_vpc.play_network.id}"
  depends_on = ["aws_vpc.play_network"]
}

#Creating network in zone A with nat gateway for private subnet
module "networkplane_a" {

  source = "modules/networkplane"
  #although mentioned as defaults in module, specifying them to clear any ambiguity
  network_aws_region  = "${var.aws_region}"
  network_aws_zone    = "a"
  network_vpc_id      = "${aws_vpc.play_network.id}"
  network_gw_id       = "${aws_internet_gateway.play_gw.id}"
  private_cidrblock   = "10.0.1.0/24"
  public_cidrblock    = "10.0.0.0/24"
}

#Creating network in zone C along with nat gateway for private subnet
module "networkplane_c" {

  source = "modules/networkplane"
  #although mentioned as defaults in module, specifying them to clear any ambiguity
  network_aws_region  = "${var.aws_region}"
  network_aws_zone    = "c"
  network_vpc_id      = "${aws_vpc.play_network.id}"
  network_gw_id       = "${aws_internet_gateway.play_gw.id}"
  private_cidrblock   = "10.0.3.0/24"
  public_cidrblock    = "10.0.2.0/24"
}

#Creating the keypair with user provided public ssh key
resource "aws_key_pair" "deploykey" {
  key_name   = "deploykey"
  public_key = "${var.publickey}"
}

# provisioning private instance zone a
module "private_instance_sg" {
  source = "modules/securitygroup"
  sg_name = "private_instance_sg"
  sg_description = "Security group for private instances"
  sg_vpc_id =  "${aws_vpc.play_network.id}"
  sg_modifyrule = true
  sg_ingress_cidr_blocks = ["10.0.0.0/22"]
  sg_rules = {
    vpc-all-tcp       = [0, 65535, "tcp", "All TCP ports within vpc"]
  }
  sg_ingress_rules = ["vpc-all-tcp"]
}

# provisioning public instance in zone c
module "public_instance_sg" {
  source = "modules/securitygroup"
  sg_name = "public_instance_sg"
  sg_description = "Security group for public instances"
  sg_vpc_id =  "${aws_vpc.play_network.id}"
  sg_modifyrule = true
  sg_ingress_cidr_blocks = ["0.0.0.0/0"]
  sg_rules = {
    ssh-tcp = [22, 22, "tcp", "SSH"]
  }
  sg_ingress_rules = ["ssh-tcp"]
}


module "private_subnet_instance" {

  source = "modules/compute"

  service_name = "private"
  instance_count = 1
  instance_subnet = ["${module.networkplane_a.networkplane_privatesubnet_id}"]
  instance_sg = ["${module.private_instance_sg.securitygroup_sg_id}"]
  hostname_prefix = "zene"
  instance_type = "t3.micro"
  instance_deploykey = "${aws_key_pair.deploykey.key_name}"
  boot_disk_image = "ami-08fd8ae3806f09a08"
  boot_disk_size = 20
  instance_role = "private"
}


module "public_subnet_instance" {

  source = "modules/compute"

  service_name = "public"
  instance_count = 1
  instance_public_ip = true
  instance_subnet = ["${module.networkplane_c.networkplane_publicsubnet_id}"]
  instance_sg = ["${module.public_instance_sg.securitygroup_sg_id}"]
  hostname_prefix = "zene"
  instance_type = "t3.micro"
  instance_deploykey = "${aws_key_pair.deploykey.key_name}"
  boot_disk_image = "ami-08fd8ae3806f09a08"
  boot_disk_size = 20
  instance_role = "public"
}
