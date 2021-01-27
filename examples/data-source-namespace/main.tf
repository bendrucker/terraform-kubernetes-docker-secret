module "image_pull_secret" {
  source = "bendrucker/docker-secret/kubernetes"

  name      = "dockerhub"
  namespace = data.kubernetes_namespace.default.id

  registries = {
    "https://index.docker.io/v1/" = {
      username = "user"
      password = "password"
    }
  } 
}

resource "kubernetes_service_account" "sa" {
  metadata {
    name      = "my-service-account"
    namespace = data.kubernetes_namespace.default.id
  }
}

data "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
}
