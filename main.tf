# Security Groups
resource "aws_security_group" "this" {
  count       = var.enabled ? 1 : 0
  name        = "${var.env}-openvpn-connector"
  description = "Security Group for Cloud OpenVPN EC2 Instance (connector)"
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
    Name      = "${var.env}-openvpn-connector"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

# EC2
resource "aws_instance" "this" {
  count                  = var.enabled ? 1 : 0
  ami                    = join("", data.aws_ami.ubuntu_20_04.*.id)
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.this.name
  subnet_id              = var.private_subnets[0]
  key_name               = var.ec2_key_pair_name
  vpc_security_group_ids = [aws_security_group.this[0].id]
  
  disable_api_termination = true

  lifecycle {
    ignore_changes = all
  }

  user_data              = data.template_file.ec2_user_data.rendered

  tags = {
    Terraform = "true"
    Env       = var.env
    Name      = "${var.env}-openvpn-connector"
  }

}
