resource "aws_elasticache_subnet_group" "this" {
  name       = "${local.resource_prefix_name}-cache"
  subnet_ids = var.subnet_elasticache_group
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = "${local.resource_prefix_name}-cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379

  subnet_group_name = aws_elasticache_subnet_group.this.name

  apply_immediately = true

  tags = {
    Name = "${local.resource_prefix_name}-cache"
  }
}