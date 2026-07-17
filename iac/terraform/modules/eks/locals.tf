locals {
  resource_prefix_name = "fiap-tc-f4"
  aws_eks_add_ons = [
    "kube-proxy",
    "coredns",
    "metrics-server",
    "external-dns",
    "vpc-cni",
    "eks-node-monitoring-agent",
    "eks-pod-identity-agent",
    "aws-ebs-csi-driver"
  ]
}