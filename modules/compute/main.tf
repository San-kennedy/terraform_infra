# ----------------------------------------------------------------------------------------------
# Setting up the VM
# ----------------------------------------------------------------------------------------------

resource aws_instance "vms"{

  count = "${var.instance_count}"
  ami = "${var.boot_disk_image}"
  security_groups = ["${var.instance_sg}"]
  private_ip = "${length(var.instance_ip) > 0 ? element(concat(var.instance_ip, list("")), count.index) : "" }"
  associate_public_ip_address = "${var.instance_public_ip}"
  instance_type = "${var.instance_type}"
  root_block_device {
    volume_type = "${var.boot_disk_type}"
    volume_size = "${var.boot_disk_size}"
  }
  subnet_id = "${length(var.instance_subnet) > 0 ? element(var.instance_subnet,count.index) : ""}"
  key_name = "${var.instance_deploykey}"
  user_data = "${element(data.template_file.sethostname.*.rendered, count.index)}"

  tags = {
    vmrole="${var.instance_role}"
    Name="${var.instance_hostname == "" ? format("%s-%s-0%d", var.hostname_prefix, var.service_name,count.index + 1) : var.instance_hostname}"
  }

    lifecycle {
    ignore_changes = [
      # Ignore changes to
      "security_groups",
      "ebs_block_device",
      "tags",
      "user_data"
    ]
  }

}

data "template_file" "sethostname" {
  count = "${var.instance_count}"
  template = "${file("${path.module}/hostname.tpl")}"
  vars = {
    vm_hostname = "${var.instance_hostname == "" ? format("%s-%s-0%d", var.hostname_prefix, var.service_name,count.index + 1) : var.instance_hostname}"
  }
}
