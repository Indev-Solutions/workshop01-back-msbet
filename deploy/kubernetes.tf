terraform {
  backend "s3" {
    bucket = "brstworkshop1"
    key    = "rst/iac"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.29.0"
    }
  }

  required_version = "~> 1.7"
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "region" {
  type        = string
  description = "AWS region for all cloud resources"
}

variable "database_hostname" {
  type        = string
  description = "Hostname of database"
  sensitive   = true
}

variable "database_password" {
  type        = string
  description = "Password of database"
  sensitive   = true
}

resource "kubernetes_deployment" "deployment-msbet" {
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
            name  = "DATABASE_URL"
            value = "jdbc:postgresql://${var.DATABASE_HOSTNAME}:5432/workshop"
          }

          env {
            name  = "DATABASE_USER"
            value = "dbadmin"
          }

          env {
            name  = "DATABASE_PASSWORD"
            value = var.DATABASE_PASSWORD
          }

          port {
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

resource "kubernetes_service" "msbet-service" {
  metadata {
    name = "workshop1-service-msbet"

    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
      "service.beta.kubernetes.io/aws-load-balancer-type"     = "nlb"
    }
  }

  spec {
    selector = {
      app = kubernetes_deployment.deployment-msbet.metadata.0.labels.app
    }

    port {
      port        = 80
      target_port = 8080
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}
