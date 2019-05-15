#------------------------------------------------------------------------------
# ec2 resources
#------------------------------------------------------------------------------

locals {
  namespace = "${var.namespace}"
}

resource "aws_instance" "ec2" {
  ami                    = "${var.aws_instance_ami}"
  instance_type          = "${var.aws_instance_type}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  key_name               = "${var.ssh_key_name}"

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags {
    Name  = "${local.namespace}-instance"
  }
}

resource "aws_eip" "ec2" {
  instance = "${aws_instance.ec2.id}"
  vpc      = true
}

