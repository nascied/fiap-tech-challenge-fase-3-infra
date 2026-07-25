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

  # Configuration values por add-on. O vpc-cni habilita prefix delegation para
  # elevar o limite de pods por node (t3.medium fica limitado a 17 pods/node sem isso).
  aws_eks_add_ons_configuration_values = {
    "vpc-cni" = jsonencode({
      env = {
        ENABLE_PREFIX_DELEGATION = "true"
        WARM_PREFIX_TARGET       = "1"
      }
    })
  }
}