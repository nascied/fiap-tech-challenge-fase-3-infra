## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.36.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cache"></a> [cache](#module\_cache) | ./modules/elasticache | n/a |
| <a name="module_db"></a> [db](#module\_db) | ./modules/rds | n/a |
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | ./modules/dynamodb | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ./modules/registry | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/cluster | n/a |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ./modules/sqs | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_dynamodb_table_name"></a> [aws\_dynamodb\_table\_name](#input\_aws\_dynamodb\_table\_name) | Nome da tabela DynamoDB | `string` | n/a | yes |
| <a name="input_aws_sqs_queue_name"></a> [aws\_sqs\_queue\_name](#input\_aws\_sqs\_queue\_name) | n/a | `string` | n/a | yes |
| <a name="input_aws_vpc"></a> [aws\_vpc](#input\_aws\_vpc) | Configuração de rede AWS | <pre>object({<br/>    name                     = string<br/>    cidr_block               = string<br/>    internet_gateway_name    = string<br/>    nat_gateway_name         = string<br/>    public_route_table_name  = string<br/>    private_route_table_name = string<br/>    public_subnets = list(object({<br/>      name                    = string<br/>      cidr_block              = string<br/>      availability_zone       = string<br/>      map_public_ip_on_launch = bool<br/>    }))<br/>    private_subnets = list(object({<br/>      name                    = string<br/>      cidr_block              = string<br/>      availability_zone       = string<br/>      map_public_ip_on_launch = bool<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_rds"></a> [rds](#input\_rds) | n/a | <pre>object({<br/>    rds_properties = list(object({<br/>      name    = string<br/>      db_name = string<br/>      db_user = string<br/>      db_pass = string<br/>    }))<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_db_instance_connection_strings"></a> [aws\_db\_instance\_connection\_strings](#output\_aws\_db\_instance\_connection\_strings) | PostgreSQL connection string |
| <a name="output_aws_db_instance_endpoint"></a> [aws\_db\_instance\_endpoint](#output\_aws\_db\_instance\_endpoint) | RDS endpoint |
| <a name="output_aws_db_instance_hostname"></a> [aws\_db\_instance\_hostname](#output\_aws\_db\_instance\_hostname) | RDS hostname |
| <a name="output_aws_db_instance_master_user"></a> [aws\_db\_instance\_master\_user](#output\_aws\_db\_instance\_master\_user) | Master username |
| <a name="output_aws_db_instance_name"></a> [aws\_db\_instance\_name](#output\_aws\_db\_instance\_name) | Database name |
| <a name="output_aws_db_instance_port"></a> [aws\_db\_instance\_port](#output\_aws\_db\_instance\_port) | RDS port |
| <a name="output_aws_ecr_repository_arn"></a> [aws\_ecr\_repository\_arn](#output\_aws\_ecr\_repository\_arn) | ARN no registry de imagem |
| <a name="output_aws_ecr_repository_registry_id"></a> [aws\_ecr\_repository\_registry\_id](#output\_aws\_ecr\_repository\_registry\_id) | Id do registry de imagem |
| <a name="output_aws_ecr_repository_repository_url"></a> [aws\_ecr\_repository\_repository\_url](#output\_aws\_ecr\_repository\_repository\_url) | URL do registry de imagem |
| <a name="output_aws_eks_cluster_arn"></a> [aws\_eks\_cluster\_arn](#output\_aws\_eks\_cluster\_arn) | ARN do cluster EKS |
| <a name="output_aws_eks_cluster_endpoint"></a> [aws\_eks\_cluster\_endpoint](#output\_aws\_eks\_cluster\_endpoint) | Endereço do endpoint do cluster EKS |
| <a name="output_aws_eks_cluster_id"></a> [aws\_eks\_cluster\_id](#output\_aws\_eks\_cluster\_id) | Id do clueste EKS |
| <a name="output_aws_eks_cluster_platform_version"></a> [aws\_eks\_cluster\_platform\_version](#output\_aws\_eks\_cluster\_platform\_version) | Versão do cluster EKS |
| <a name="output_aws_elasticache_cluster_arn"></a> [aws\_elasticache\_cluster\_arn](#output\_aws\_elasticache\_cluster\_arn) | Arn do elasticache |
| <a name="output_aws_elasticache_cluster_cache_nodes"></a> [aws\_elasticache\_cluster\_cache\_nodes](#output\_aws\_elasticache\_cluster\_cache\_nodes) | Informações de nodes cache |
| <a name="output_aws_elasticache_cluster_cluster_address"></a> [aws\_elasticache\_cluster\_cluster\_address](#output\_aws\_elasticache\_cluster\_cluster\_address) | Endereço do cluster elasticache |
| <a name="output_aws_elasticache_cluster_configuration_endpoint"></a> [aws\_elasticache\_cluster\_configuration\_endpoint](#output\_aws\_elasticache\_cluster\_configuration\_endpoint) | Endpoint do elasticache |
| <a name="output_aws_elasticache_cluster_engine_version_actual"></a> [aws\_elasticache\_cluster\_engine\_version\_actual](#output\_aws\_elasticache\_cluster\_engine\_version\_actual) | Versão da engine do elasticache |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | ID do internet gateway |
| <a name="output_private_subnet_arns"></a> [private\_subnet\_arns](#output\_private\_subnet\_arns) | ARN das subnets privadas |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | Ids das subnets privadas |
| <a name="output_public_subnet_arns"></a> [public\_subnet\_arns](#output\_public\_subnet\_arns) | ARN das subnets publicas |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | Ids das subnetes publicas |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID da VPC |
