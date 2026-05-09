#


# Security Group para RDS
resource "aws_security_group" "this" {
  name        = "${local.resource_prefix_name}-rds-postgres-sg"
  description = "Security group para RDS PostgreSQL"
  vpc_id      = var.aws_db_subnet_group_vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.16.10.0/24", "172.16.11.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-postgres-sg"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = "${local.resource_prefix_name}-db-subnet-group"
  subnet_ids = var.aws_subnet_ids

  tags = {
    Name = "${local.resource_prefix_name}-db-subnet-group"
  }

}

# RDS PostgreSQL - Free Tier Optimized
resource "aws_db_instance" "this" {
  count      = length(var.rds.rds_properties)
  identifier = var.rds.rds_properties[count.index].name
  # Engine Configuration - Free Tier Compatible
  engine            = "postgres"
  engine_version    = "18.1"        # Versão suportada no free tier
  instance_class    = "db.t3.micro" # Free tier elegível
  allocated_storage = 20            # 20 GB free tier limit
  storage_type      = "gp2"         # General Purpose SSD
  storage_encrypted = false         # Desabilitado para free tier

  # Database Configuration
  db_name  = var.rds.rds_properties[count.index].db_name
  username = var.rds.rds_properties[count.index].db_user
  password = var.rds.rds_properties[count.index].db_pass

  # Backup Configuration - DESABILITADO
  backup_retention_period = 0 # Sem backups automáticos
  backup_window           = null
  copy_tags_to_snapshot   = false
  skip_final_snapshot     = true # Não criar snapshot ao deletar

  # Maintenance
  maintenance_window         = "sun:03:00-sun:04:00"
  auto_minor_version_upgrade = true

  # Monitoramento - DESABILITADO
  enabled_cloudwatch_logs_exports = [] # Sem logs
  monitoring_interval             = 0  # Sem enhanced monitoring
  monitoring_role_arn             = null
  performance_insights_enabled    = false
  deletion_protection             = false

  # Multi-AZ - DESABILITADO (não elegível free tier)
  multi_az = false

  # Redes
  db_subnet_group_name   = aws_db_subnet_group.this.name
  publicly_accessible    = true # Para acesso local/dev
  vpc_security_group_ids = [aws_security_group.this.id]

  # Tags
  tags = {
    Name = var.rds.rds_properties[count.index].name
  }

  depends_on = [aws_db_subnet_group.this]
}

