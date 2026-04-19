locals {
  resource_prefix_name = "fiap-tc-f3"
  repository_name = ["${local.resource_prefix_name}-auth",
    "${local.resource_prefix_name}-flag",
    "${local.resource_prefix_name}-targeting",
    "${local.resource_prefix_name}-evaluation",
  "${local.resource_prefix_name}-analytics"]
}