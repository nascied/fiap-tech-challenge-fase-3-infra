variable "aws_vpc" {
  description = "Configuração de rede AWS"
  type = object({
    name                     = string
    cidr_block               = string
    internet_gateway_name    = string
    nat_gateway_name         = string
    public_route_table_name  = string
    private_route_table_name = string
    public_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
    private_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
  })
}

variable "rds" {
  type = object({
    rds_properties = list(object({
      name    = string
      db_name = string
      db_user = string
      db_pass = string
    }))
  })
}

variable "aws_sqs_queue_name" {
  type = string
}

variable "aws_dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
}


variable "aws_eks_cluster_version" {
  type = string
}