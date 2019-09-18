#Providing module outputs that point to subnet ids
output "networkplane_privatesubnet_id" {
  description = "private subnet id"
  value = "${aws_subnet.private_cidr.id}"
}

output "networkplane_publicsubnet_id" {
  description = "public subnet id"
  value = "${aws_subnet.public_cidr.id}"
}
