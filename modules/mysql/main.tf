resource "kubernetes_deployment_v1" "mysql" {
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
        tier = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
          tier = "mysql"
        }
      }

      spec {
        container {
          image = "mariadb:10.7"
          name = "mysql"
          env {
            name = "MYSQL_DATABASE"
            value = "wordpress"
          }
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value = "password"
          }
          port {
            container_port = 3306
            name = "mysql"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "mysql" {
  metadata {
    name = var.name
    labels = {
      app = "wordpress"
    }
  }

  spec {
    selector = {
      app  = "wordpress"
      tier = "mysql"
    }

    port {
      port        = 3306
      target_port = 3306
    }

    type = "ClusterIP"
  }
}

variable "name" {
  type = string
}
variable "app_name" {
  type = string
}