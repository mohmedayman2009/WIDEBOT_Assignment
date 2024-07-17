# Web application service
resource "kubernetes_service" "app" {
  metadata {
    name = "my-app"
  }
  spec {
    selector = {
      app = "my-app"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

# MongoDB service
resource "kubernetes_service" "mongo" {
  metadata {
    name = "mongo"
  }
  spec {
    selector = {
      app = "mongo"
    }
    port {
      name        = "mongo"
      port        = 27017
      target_port = 27017
    }
  }
}

# SQL Server service
resource "kubernetes_service" "sql" {
  metadata {
    name = "sql"
  }
  spec {
    selector = {
      app = "sql"
    }
    port {
      name        = "sql"
      port        = 1433
      target_port = 1433
    }
  }
}

# Redis service
resource "kubernetes_service" "redis" {
  metadata {
    name = "redis"
  }
  spec {
    selector = {
      app = "redis"
    }
    port {
      name        = "redis"
      port        = 6379
      target_port = 6379
    }
  }
}
