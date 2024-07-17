# Variable for Kubernetes cluster context
variable "k8s_cluster_context" {
  description = "The Kubernetes cluster context name"
  type        = string
  default     = "my-kubernetes-cluster"
}

# Variable for the domain name
variable "domain_name" {
  description = "The domain name for the application"
  type        = string
  default     = "my-app.example.com"
}
