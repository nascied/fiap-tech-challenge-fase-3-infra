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
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_subnet_ids"></a> [aws\_subnet\_ids](#input\_aws\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_rds"></a> [rds](#input\_rds) | n/a | <pre>object({<br/>    rds_properties = list(object({<br/>      name    = string<br/>      db_name = string<br/>      db_user = string<br/>      db_pass = string<br/>    }))<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_db_instance_connection_strings"></a> [aws\_db\_instance\_connection\_strings](#output\_aws\_db\_instance\_connection\_strings) | Lista de connection strings dos bancos RDS |
| <a name="output_aws_db_instance_endpoint"></a> [aws\_db\_instance\_endpoint](#output\_aws\_db\_instance\_endpoint) | RDS endpoint |
| <a name="output_aws_db_instance_hostname"></a> [aws\_db\_instance\_hostname](#output\_aws\_db\_instance\_hostname) | RDS hostname |
| <a name="output_aws_db_instance_master_user"></a> [aws\_db\_instance\_master\_user](#output\_aws\_db\_instance\_master\_user) | Master username |
| <a name="output_aws_db_instance_name"></a> [aws\_db\_instance\_name](#output\_aws\_db\_instance\_name) | Database name |
| <a name="output_aws_db_instance_port"></a> [aws\_db\_instance\_port](#output\_aws\_db\_instance\_port) | RDS port |
