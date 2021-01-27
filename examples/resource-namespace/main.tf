module "image_pull_secret" {
  source = "bendrucker/docker-secret/kubernetes"

  name      = "dockerhub"
  namespace = kubernetes_namespace.ns.id

  registries = {
    "https://index.docker.io/v1/" = {
      username = "user"
      password = "password"
    }
  } 
}

resource "kubernetes_namespace" "ns" {
  metadata {
    name = "my-namespace"
  }
}

resource "kubernetes_service_account" "sa" {
  metadata {
    name      = "my-service-account"
    namespace = kubernetes_namespace.ns.id
  }
}

