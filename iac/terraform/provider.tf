provider "aws" {

  default_tags {
    tags = {
      created_by = "terraform"
    }
  }
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.aws_eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.aws_eks_cluster_certificate_authority_data)

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.aws_eks_cluster_name]
    }
  }
}