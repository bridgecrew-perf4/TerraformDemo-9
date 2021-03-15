##################################################
# Packer Configuration
##################################################
packer {
  required_version = ">= 1.7.0"
}

##################################################
# Source Block
##################################################
source "amazon-ebs" "amzn2-nginx" {
  region        = var.REGION
  ami_name      = "amazonlinux2-nginx-ami"
  instance_type = var.INSTANCE_TYPE
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username = "ec2-user"

  tags = {
    Name = "${local.ENVIRONMENT}-amzn2-nginx"
    Env  = local.ENVIRONMENT
  }
}

##################################################
# Build Block
##################################################
build {
  sources = [
    "source.amazon-ebs.amzn2-nginx"
  ]

  provisioner "ansible" {
    playbook_file = "./aws_amzn2_install-nginx_playbook.yml"
  }
}