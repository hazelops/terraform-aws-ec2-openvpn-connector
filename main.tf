# Security Groups
resource "aws_security_group" "this" {
  name        = local.name
  description = "Security Group for Bastion + Cloud OpenVPN EC2 connector"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow all ingress traffic"
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow all egress traffic"
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = "true"
    Env       = var.env
    Name      = local.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

# EC2
resource "aws_instance" "this" {
  ami                  = join("", data.aws_ami.ubuntu_20_04.*.id)
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.this.name
  subnet_id            = var.private_subnets[0]
  key_name             = var.ec2_key_pair_name
  vpc_security_group_ids = concat(var.ext_security_groups, [
    aws_security_group.this.id
  ])

  associate_public_ip_address = false

  lifecycle {
    ignore_changes = all
  }

  user_data = var.vpn_enabled ? data.template_file.ec2_user_data.rendered : null

  tags = {
    Terraform = "true"
    Env       = var.env
    Name      = local.name
    OpenVpn   = var.vpn_enabled ? "enabled" : "disabled"
    Bastion   = var.bastion_enabled ? "enabled" : "disabled"
  }

}
