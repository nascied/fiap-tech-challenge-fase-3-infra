resource "aws_eks_cluster" "this" {
  name     = "${local.resource_prefix_name}-eks"
  version  = var.aws_eks_cluster_version
  role_arn = data.aws_iam_role.this.arn

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = var.aws_subnet_public_ids
  }

  depends_on = [
    data.aws_iam_role.this
  ]
}

resource "aws_eks_addon" "this" {
  for_each     = toset(local.aws_eks_add_ons)
  cluster_name = aws_eks_cluster.this.name
  addon_name   = each.value
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${local.resource_prefix_name}-mng"
  node_role_arn   = data.aws_iam_role.this.arn
  subnet_ids      = var.aws_subnet_private_ids
  instance_types  = ["t3.medium"]
  capacity_type   = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.this,
    data.aws_iam_role.this
  ]
}

resource "aws_eks_access_entry" "this" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/voclabs"

  type = "STANDARD"
  # user_name = "arn:aws:sts::226226079541:assumed-role/voclabs/{{SessionName}}"
}

resource "aws_eks_access_policy_association" "this" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/voclabs"


  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [
    aws_eks_access_entry.this
  ]
}