# Provider configurations
provider "kubernetes" {
  config_context_cluster = var.k8s_cluster_context
  config_path = "~/.kube/config"
}
