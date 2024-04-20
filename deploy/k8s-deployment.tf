provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "DATABASE_HOSTNAME" {
  type        = string
  description = "Hostname of database"
  sensitive   = true
}

variable "DATABASE_PASSWORD" {
  type        = string
  description = "Password of database"
  sensitive   = true
}

resource "kubernetes_deployment" "msbet-deployment" {
  metadata {
    name = "workshop1-deployment-msbet"
    labels = {
      app = "workshop1-backend-msbet"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "workshop1-backend-msbet"
      }
    }

    template {
      metadata {
        labels = {
          app = "workshop1-backend-msbet"
        }
      }

      spec {
        container {
          image = "indevsolutions/workshop1:ms-bet_v5"
          name  = "customservicebet"

          env {
            name = "DATABASE_URL"
            value = "jdbc:postgresql://${var.DATABASE_HOSTNAME}:5432/workshop"
          }

          env {
            name = "DATABASE_USER"
            value = "dbadmin"
          }

          env {
            name = "DATABASE_PASSWORD"
            value = var.DATABASE_PASSWORD
          }

          port = {
            container_port = 8080
            name           = "tcp"
          }
          
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
