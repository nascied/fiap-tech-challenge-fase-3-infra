output "aws_eks_cluster_id" {
  value = aws_eks_cluster.this.id
}

output "aws_eks_cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "aws_eks_cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "aws_eks_cluster_platform_version" {
  value = aws_eks_cluster.this.platform_version
}