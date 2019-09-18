output "vms_instance_id" {
  description = "List of instanceIds provisioned"
  value = "${aws_instance.vms.*.id}"
}


output "vms_instance_ips" {
  description = "List of instanceIps provisioned"
  value = "${aws_instance.vms.*.private_ip}"
}

output "vms_instance_publicips" {
  description = "List of instanceIps provisioned"
  value = "${aws_instance.vms.*.public_ip}"
}

output "vms_instance_zones" {
  description = "List of regions where resective instance is provisioned"
  value = "${aws_instance.vms.*.availability_zone}"
}


output "vms_instance_arn_link" {
  description = "List of instance self links"
  value = "${aws_instance.vms.*.arn}"
}


output "vms_instance_count" {
  description = "Pass through of input instance count"
  value       = "${var.instance_count}"
}

output "vms_instance_srv_name" {
  description = "Pass through of input `instance service name`."
  value       = "${var.service_name}"
}
