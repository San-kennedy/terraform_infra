# ----------------------------------------------------------------------------------------------
# Setting up private and public subnet along with NATGW
# ----------------------------------------------------------------------------------------------

#Creating the private subnet 
resource "aws_subnet" "private_cidr" {
  vpc_id     = "${var.network_vpc_id}"
  cidr_block = "${var.private_cidrblock}"
  availability_zone = "${var.network_aws_region}${var.network_aws_zone}"
  tags = {
    Name = "private_subnet-${var.network_aws_zone}"
  }
}

#Creating the public subnet 
resource "aws_subnet" "public_cidr" {
  vpc_id     = "${var.network_vpc_id}"
  cidr_block = "${var.public_cidrblock}"
  availability_zone = "${var.network_aws_region}${var.network_aws_zone}"
  tags = {
    Name = "public_subnet-${var.network_aws_zone}"
  }
}

#Reserving and EIP for natgw instance
resource "aws_eip" "natgwip" {
  vpc = true
}

#Provisioning natgw on public subnet
resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.natgwip.id}"
  subnet_id     = "${aws_subnet.public_cidr.id}"

  tags = {
    Name = "NAT Gateway-${var.network_aws_zone}"
  }
}

#Creating route table for private subnet, pointing trafic to nat instance
resource "aws_route_table" "private_subnetrt" {
  vpc_id = "${var.network_vpc_id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw.id}"
  }
  tags = {
    Name = "PrivateRT-${var.network_aws_zone}"
  }
}

#Creating route table for public subnet, pointing trafic to IGW
resource "aws_route_table" "public_subnetrt" {
  vpc_id = "${var.network_vpc_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.network_gw_id}"
  }
  tags = {
    Name = "PublicRT-${var.network_aws_zone}"
  }
}

#Associating restective routing table with respective subnets
resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private_cidr.id}"
  route_table_id = "${aws_route_table.private_subnetrt.id}"
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public_cidr.id}"
  route_table_id = "${aws_route_table.public_subnetrt.id}"
}
