output "private_instance_ip" {
  value = "${module.private_subnet_instance.vms_instance_ips}"
}

output "public_instance_ip" {
  value = "${module.public_subnet_instance.vms_instance_publicips}"
}