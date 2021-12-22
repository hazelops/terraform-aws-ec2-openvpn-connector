# AWS OpenVPN Cloud Connector
This module is used to deploy a [connector](https://openvpn.net/cloud-docs/connector/) to OpenVPN Cloud.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.ubuntu_20_04](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.ec2_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of network subnets that are allowed. According to PCI-DSS, CIS AWS and SOC2 providing a default wide-open CIDR is not secure. | `list(string)` | n/a | yes |
| <a name="input_bastion_enabled"></a> [bastion\_enabled](#input\_bastion\_enabled) | Gives ability to enable or disable Bastion functionality | `bool` | `true` | no |
| <a name="input_ec2_key_pair_name"></a> [ec2\_key\_pair\_name](#input\_ec2\_key\_pair\_name) | n/a | `any` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `any` | n/a | yes |
| <a name="input_ext_security_groups"></a> [ext\_security\_groups](#input\_ext\_security\_groups) | External security groups to add to bastion host | `list(any)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t3.nano"` | no |
| <a name="input_openvpn_token"></a> [openvpn\_token](#input\_openvpn\_token) | n/a | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_ssh_forward_rules"></a> [ssh\_forward\_rules](#input\_ssh\_forward\_rules) | Rules that will enable port forwarding. SSH Config syntax | `list(string)` | `[]` | no |
| <a name="input_ssm_role_arn"></a> [ssm\_role\_arn](#input\_ssm\_role\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |
| <a name="input_vpn_enabled"></a> [vpn\_enabled](#input\_vpn\_enabled) | Gives ability to enable or disable Cloud OpenVPN EC2 connector functionality | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cmd"></a> [cmd](#output\_cmd) | n/a |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | n/a |
| <a name="output_ssh_config"></a> [ssh\_config](#output\_ssh\_config) | n/a |
