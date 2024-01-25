data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  filter {
    name = "name"
    # Ubuntu 22.04 LTS amd64 image in us-east-1. If upgrade is needed, you would need to re-connect to openvpn.
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230601"]
  }
  owners = ["099720109477"] # Canonical
}
