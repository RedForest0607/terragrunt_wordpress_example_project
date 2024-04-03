resource "kubernetes_deployment_v1" "wordpress" {
  metadata {
    name = var.name
    labels = {
      app = var.app_name
    }
  }

   spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.app_name
        tier = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
          tier = "frontend"
        }
      }

      spec {
        container {
          image = "wordpress:5.9.1-php8.1-apache"
          name = "wordpress"
          env {
            name = "WORDPRESS_DB_HOST"
            value = "wordpress-mysql"
          }
          env {
            name = "WORDPRESS_DB_NAME"
            value = "wordpress"
          }
          env {
            name = "WORDPRESS_DB_USER"
            value = "root"
          }
          env {
            name = "WORDPRESS_DB_PASSWORD"
            value = "password"
          }
          port {
            container_port = 80
            name = "wordpress"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress"
    labels = {
      app = "wordpress"
    }
  }

  spec {
    selector = {
      app  = "wordpress"
      tier = "frontend"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}

variable "name" {
  type = string
}
variable "app_name" {
  type = string
}