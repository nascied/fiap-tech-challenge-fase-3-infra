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

variable "aws_subnet_ids" {
  type = list(string)
}

variable "aws_db_subnet_group_vpc_id" {
  type = string
}

variable "eks_security_group_id" {
  type        = string
  description = "Security group id do cluster EKS, autorizado a acessar o RDS na porta 5432"
}