# Ingress resource for routing and SSL termination
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
      hosts      = [var.domain_name]
      secret_name = "my-app-tls"
    }
    rule {
      host = var.domain_name
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
