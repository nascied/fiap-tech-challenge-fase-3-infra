output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID da VPC"
}

output "internet_gateway_id" {
  value       = module.vpc.internet_gateway_id
  description = "ID do internet gateway"
}

output "public_subnet_arns" {
  value       = module.vpc.public_subnet_arns
  description = "ARN das subnets publicas"
}

output "private_subnet_arns" {
  value       = module.vpc.private_subnet_arns
  description = "ARN das subnets privadas"
}

output "private_subnet_id" {
  value       = module.vpc.private_subnet_id
  description = "Ids das subnets privadas"
}

output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
  description = "Ids das subnetes publicas"
}

#----------------------------------------
# Output RDS database
#----------------------------------------

output "aws_db_instance_endpoint" {
  description = "RDS endpoint"
  value       = module.db.aws_db_instance_endpoint
}

output "aws_db_instance_hostname" {
  description = "RDS hostname"
  value       = module.db.aws_db_instance_hostname
}

output "aws_db_instance_port" {
  description = "RDS port"
  value       = module.db.aws_db_instance_port
}

output "aws_db_instance_name" {
  description = "Database name"
  value       = module.db.aws_db_instance_name
  sensitive   = false
}

output "aws_db_instance_master_user" {
  description = "Master username"
  value       = module.db.aws_db_instance_master_user
  sensitive   = false
}

output "aws_db_instance_connection_strings" {
  description = "PostgreSQL connection string"
  value       = module.db.aws_db_instance_connection_strings
  sensitive   = true
}

#----------------------------------------
# Output cluster eks
#----------------------------------------

output "aws_eks_cluster_id" {
  value       = module.eks.aws_eks_cluster_id
  description = "Id do clueste EKS"
}

output "aws_eks_cluster_arn" {
  value       = module.eks.aws_eks_cluster_arn
  description = "ARN do cluster EKS"
}

output "aws_eks_cluster_endpoint" {
  value       = module.eks.aws_eks_cluster_endpoint
  description = "Endereço do endpoint do cluster EKS"
}

output "aws_eks_cluster_platform_version" {
  value       = module.eks.aws_eks_cluster_platform_version
  description = "Versão do cluster EKS"
}

output "aws_eks_cluster_security_group_id" {
  value       = module.eks.aws_eks_cluster_security_group_id
  description = "Security group do cluster EKS (control plane e node group)"
}

#---------------------------------------
# Output do registry
#---------------------------------------

output "aws_ecr_repository_arn" {
  value       = module.ecr.aws_ecr_repository_arn
  description = "ARN no registry de imagem"
}

output "aws_ecr_repository_registry_id" {
  value       = module.ecr.aws_ecr_repository_registry_id
  description = "Id do registry de imagem"
}

output "aws_ecr_repository_repository_url" {
  value       = module.ecr.aws_ecr_repository_repository_url
  description = "URL do registry de imagem"
}

#---------------------
# SQS outputs
#---------------------

output "sqs_queue_url" {
  description = "URL da fila SQS"
  value       = module.sqs.sqs_queue_url
}

output "sqs_queue_arn" {
  description = "ARN da fila SQS"
  value       = module.sqs.sqs_queue_arn
}

output "sqs_queue_name" {
  description = "Nome da fila SQS"
  value       = module.sqs.sqs_queue_name
}

#----------------------------
# elasticcache
#----------------------------

output "aws_elasticache_cluster_arn" {
  value       = module.cache.aws_elasticache_cluster_arn
  description = "Arn do elasticache"
}

output "aws_elasticache_cluster_engine_version_actual" {
  value       = module.cache.aws_elasticache_cluster_engine_version_actual
  description = "Versão da engine do elasticache"
}

output "aws_elasticache_cluster_cache_nodes" {
  value       = module.cache.aws_elasticache_cluster_cache_nodes
  description = "Informações de nodes cache"
}

output "aws_elasticache_cluster_cluster_address" {
  value       = module.cache.aws_elasticache_cluster_cluster_address
  description = "Endereço do cluster elasticache"
}

output "aws_elasticache_cluster_configuration_endpoint" {
  value       = module.cache.aws_elasticache_cluster_configuration_endpoint
  description = "Endpoint do elasticache"
}

output "aws_elasticache_cluster_security_group_id" {
  value       = module.cache.aws_security_group_id
  description = "Security group do Redis"
}

#----------------------------
# DynamoDB
#----------------------------

output "aws_dynamodb_table_name" {
  value       = module.dynamodb.aws_dynamodb_table_name
  description = "Nome da tabela DynamoDB"
}

output "aws_dynamodb_table_arn" {
  value       = module.dynamodb.aws_dynamodb_table_arn
  description = "ARN da tabela DynamoDB"
}

output "aws_dynamodb_table_id" {
  value       = module.dynamodb.aws_dynamodb_table_id
  description = "ID da tabela DynamoDB"
}
