provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = "my-first-namespace"
  }
}
