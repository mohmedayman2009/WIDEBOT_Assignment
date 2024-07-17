# Define the provider and its configurations
provider "kubernetes" {
  config_context_cluster = "my-kubernetes-cluster"
  config_path = "~/.kube/config"
}

# Call the Kubernetes modules
module "kubernetes" {
  source = "./kubernetes"
}

# Set up domain name and SSL
resource "kubernetes_ingress" "app" {
  metadata {
    name = "my-app"
    annotations = {
      "kubernetes.io/ingress.class"                = "nginx"
      "nginx.ingress.kubernetes.io/ssl-redirect"   = "true"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    tls {
      hosts      = ["my-app.example.com"]
      secret_name = "my-app-tls"
    }

    rule {
      host = "my-app.example.com"
      http {
        path {
          backend {
            service_name = "my-app"
            service_port = 80
          }
        }
      }
    }
  }
}
