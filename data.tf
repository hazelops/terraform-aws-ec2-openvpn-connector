data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "ec2_user_data" {
  template = file("${path.module}/ec2_user_data.sh.tpl")

  vars = {
    openvpn_token = var.openvpn_token
  }
}

data "aws_ami" "ubuntu_20_04" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
