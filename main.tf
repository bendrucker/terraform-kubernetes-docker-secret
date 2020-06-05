resource "kubernetes_secret" "docker" { 
  metadata {
    name = var.name
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"
  
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        for host, creds in var.registries : host => merge(
          {for k, v in creds : k => v if v != null},
          {auth = base64encode("${creds.username}:${creds.password}")},
        )
      }
    })
  }
}
