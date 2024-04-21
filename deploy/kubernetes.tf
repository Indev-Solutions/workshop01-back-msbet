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

variable "apigateway_jwt_configuration_audience" {
  type        = string
  description = "Audience of JWT configuration for api gateway"
  sensitive   = true
}

variable "apigateway_jwt_configuration_issuer" {
  type        = string
  description = "Issuer of JWT configuration for api gateway"
  sensitive   = true
}

data "terraform_remote_state" "integration" {
  backend = "s3"

  config = {
    bucket = "brstworkshop1"
    key    = "env:/workshop1-pro-integration/rst/iac"
    region = var.region
  }
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
            value = "jdbc:postgresql://${var.database_hostname}:5432/workshop"
          }

          env {
            name  = "DATABASE_USER"
            value = "dbadmin"
          }

          env {
            name  = "DATABASE_PASSWORD"
            value = var.database_password
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

resource "aws_apigatewayv2_api" "my_apigateway_msbet" {
  name          = "my-http-api-msbet"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "my_apigateway_stage_msbet" {
  api_id      = aws_apigatewayv2_api.my_apigateway_msbet.id
  name        = "$default"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 100
    throttling_rate_limit  = 200
  }
}

resource "aws_apigatewayv2_authorizer" "my_apigateway_authorizer_msbet" {
  name             = "my-apigateway-authorizer-msbet"
  api_id           = aws_apigatewayv2_api.my_apigateway_msbet.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]

  jwt_configuration {
    audience = [var.apigateway_jwt_configuration_audience]
    issuer   = var.apigateway_jwt_configuration_issuer
  }
}
/*
resource "aws_apigatewayv2_integration" "my_apigateway_integration_msbet" {
  api_id             = aws_apigatewayv2_api.my_apigateway_msbet.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = var.apigateway_integration_uri
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = data.terraform_remote_state.integration.outputs.my_apigateway_vpc_link_id
}

resource "aws_apigatewayv2_route" "my_apigateway_route_msbet" {
  api_id             = aws_apigatewayv2_api.my_apigateway_msbet.id
  route_key          = "ANY /workshop/bets"
  target             = "integrations/${aws_apigatewayv2_integration.my_apigateway_integration_msbet.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.my_apigateway_authorizer_msbet.id
}*/

output "load_balancer_ingress" {
  value = kubernetes_service.msbet-service.status.0.load_balancer.0.ingress.0.hostname
}
