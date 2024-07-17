# Web application deployment
resource "kubernetes_deployment" "app" {
  metadata {
    name = "my-app"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "my-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }
      spec {
        container {
          image = "aspnet-mssql-web"
          name  = "my-app"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# MongoDB deployment
resource "kubernetes_deployment" "mongo" {
  metadata {
    name = "mongo"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mongo"
      }
    }
    template {
      metadata {
        labels = {
          app = "mongo"
        }
      }
      spec {
        container {
          image = "mongo:latest"
          name  = "mongo"
          port {
            container_port = 27017
          }
        }
      }
    }
  }
}

# SQL Server deployment
resource "kubernetes_deployment" "sql" {
  metadata {
    name = "sql"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "sql"
      }
    }
    template {
      metadata {
        labels = {
          app = "sql"
        }
      }
      spec {
        container {
          image = "mcr.microsoft.com/azure-sql-edge:1.0.4"
          name  = "sql"
          env {
            name  = "ACCEPT_EULA"
            value = "Y"
          }
          env {
            name  = "SA_PASSWORD"
            value = "MyPassword123"
          }
          port {
            container_port = 1433
          }
        }
      }
    }
  }
}

# Redis deployment
resource "kubernetes_deployment" "redis" {
  metadata {
    name = "redis"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis"
      }
    }
    template {
      metadata {
        labels = {
          app = "redis"
        }
      }
      spec {
        container {
          image = "redis:latest"
          name  = "redis"
          port {
            container_port = 6379
          }
        }
      }
    }
  }
}
