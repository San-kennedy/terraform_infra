# ----------------------------------------------------------------------------------------------
# Setting up security group
# ----------------------------------------------------------------------------------------------

resource "aws_security_group" "sg" {

  name        = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id      = "${var.sg_vpc_id}"

  tags ={
      Name = "${var.sg_name}"
    }
}

resource "aws_security_group_rule" "ingress_rules" {
  count = "${var.sg_modifyrule ? length(var.sg_ingress_rules) : 0}"

  security_group_id = "${aws_security_group.sg.id}"
  type              = "ingress"

  cidr_blocks      = "${var.sg_ingress_cidr_blocks}"
  description      = "${element(var.sg_rules[element(var.sg_ingress_rules,count.index)],3)}"

  from_port = "${element(var.sg_rules[element(var.sg_ingress_rules,count.index)],0)}"
  to_port   = "${element(var.sg_rules[element(var.sg_ingress_rules,count.index)],1)}"
  protocol  = "${element(var.sg_rules[element(var.sg_ingress_rules,count.index)],2)}"
}

resource "aws_security_group_rule" "egress_rules" {

  security_group_id = "${aws_security_group.sg.id}"
  type              = "egress"

  cidr_blocks      = ["0.0.0.0/0"]
  description      = "allow all egress"

  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
}
