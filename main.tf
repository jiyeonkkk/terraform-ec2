terraform {
  required_version = ">= 0.10.3"
}

provider "aws" {
  region = "${var.aws_region}"
}


#------------------------------------------------------------------------------
# network 
#------------------------------------------------------------------------------

module "network" {
  source    = "network/"
  namespace = "${var.namespace}"
}

#------------------------------------------------------------------------------
# ec2 
#------------------------------------------------------------------------------

module "ec2" {
  source                 = "ec2/"
  namespace              = "${var.namespace}"
  aws_instance_ami       = "${var.aws_instance_ami}"
  aws_instance_type      = "${var.aws_instance_type}"
  subnet_id              = "${module.network.subnet_ids[0]}"
  vpc_security_group_ids = "${module.network.security_group_id}"
  ssh_key_name           = "${var.ssh_key_name}"
}


