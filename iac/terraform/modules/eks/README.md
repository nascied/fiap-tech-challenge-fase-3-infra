## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_subnet_private_ids"></a> [aws\_subnet\_private\_ids](#input\_aws\_subnet\_private\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_aws_subnet_public_ids"></a> [aws\_subnet\_public\_ids](#input\_aws\_subnet\_public\_ids) | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_eks_cluster_arn"></a> [aws\_eks\_cluster\_arn](#output\_aws\_eks\_cluster\_arn) | n/a |
| <a name="output_aws_eks_cluster_endpoint"></a> [aws\_eks\_cluster\_endpoint](#output\_aws\_eks\_cluster\_endpoint) | n/a |
| <a name="output_aws_eks_cluster_id"></a> [aws\_eks\_cluster\_id](#output\_aws\_eks\_cluster\_id) | n/a |
| <a name="output_aws_eks_cluster_platform_version"></a> [aws\_eks\_cluster\_platform\_version](#output\_aws\_eks\_cluster\_platform\_version) | n/a |
