variable "env" {}
variable "vpc_id" {}
variable "private_subnets" {}
variable "ec2_key_pair_name" {}
variable "openvpn_token" {}

variable "instance_type" {
  type    = string
  default = "t3.nano"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Gives ability to enable or disable Creation of NAT EC2"
}

variable "ext_security_groups" {
  description = "External security groups to add to bastion host"
  type        = list(any)
  default     = []
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "List of network subnets that are allowed"
  default = [
    "0.0.0.0/0"
  ]
}

variable "ssm_role_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

variable "ssh_forward_rules" {
  type        = list(string)
  description = "Rules that will enable port forwarding. SSH Config syntax"
  default     = []
}

locals {
  name         = "${var.env}-bastion-openvpn-connector"
  proxycommand = <<-EOT
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
    EOT
  ssh_config = concat([
    "# SSH over Session Manager",
    "host i-* mi-*",
    "ServerAliveInterval 180",
    local.proxycommand,
  ], var.ssh_forward_rules)
  ssm_document_name = local.name
}
