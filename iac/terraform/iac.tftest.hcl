mock_provider "aws" {}

variables {
  aws_vpc = {
    name                     = "fiap-tc-f3-vpc"
    cidr_block               = "172.16.0.0/16"
    internet_gateway_name    = "fiap-tc-f3-igw"
    nat_gateway_name         = "fiap-tc-f3-ngw"
    public_route_table_name  = "fiap-tc-f3-public-rt"
    private_route_table_name = "fiap-tc-f3-private-rt"
    public_subnets = [
      {
        name                    = "fiap-tc-f3-public-subnet-us-east-1a"
        cidr_block              = "172.16.1.0/24"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = true
      },
      {
        name                    = "fiap-tc-f3-public-subnet-us-east-1b"
        cidr_block              = "172.16.2.0/24"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = true
      }
    ]
    private_subnets = [
      {
        name                    = "fiap-tc-f3-private-subnet-us-east-1a"
        cidr_block              = "172.16.10.0/24"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = false
      },
      {
        name                    = "fiap-tc-f3-private-subnet-us-east-1b"
        cidr_block              = "172.16.11.0/24"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = false
      }
    ]
  }

  rds = {
    rds_properties = [
      {
        name    = "auth-service"
        db_name = "auth_db"
        db_user = "postgres"
        db_pass = "postgre123"
      },
      {
        name    = "flag-service"
        db_name = "flag_db"
        db_user = "postgres"
        db_pass = "postgre123"
      },
      {
        name    = "targeting-service"
        db_name = "targeting_db"
        db_user = "postgres"
        db_pass = "postgre123"
      }
    ]
  }

  aws_sqs_queue_name      = "evaluation-events"
  aws_dynamodb_table_name = "ToggleMasterAnalytics"
  aws_eks_cluster_version = "1.35"
}

run "plan_smoke" {
  command = plan

  assert {
    condition     = length(var.aws_vpc.public_subnets) == 2
    error_message = "A VPC deve possuir exatamente 2 subnets públicas."
  }

  assert {
    condition     = length(var.aws_vpc.private_subnets) == 2
    error_message = "A VPC deve possuir exatamente 2 subnets privadas."
  }

  assert {
    condition     = can(regex("^1\\.", var.aws_eks_cluster_version))
    error_message = "A versão do EKS deve iniciar com major 1.x."
  }

  assert {
    condition     = length(var.rds.rds_properties) > 0
    error_message = "A configuração do RDS deve conter ao menos uma instância."
  }
}

run "plan_outputs_shape" {
  command = plan

  assert {
    condition     = length(output.public_subnet_id) == 2
    error_message = "O output de subnets públicas deve retornar 2 IDs."
  }

  assert {
    condition     = length(output.private_subnet_id) == 2
    error_message = "O output de subnets privadas deve retornar 2 IDs."
  }

  assert {
    condition     = length(output.aws_ecr_repository_arn) == 5
    error_message = "O output do ECR deve retornar 5 repositórios."
  }

  assert {
    condition     = nonsensitive(output.aws_db_instance_name)[0] == "auth_db"
    error_message = "O primeiro nome de banco retornado deve ser auth_db."
  }
}
