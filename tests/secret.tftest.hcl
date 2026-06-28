provider "kubernetes" {}

run "docker_secret" {
  command = apply

  variables {
    name      = "docker-test"
    namespace = "default"

    registries = {
      "docker.reg" = {
        username = "USER"
        password = "PASS"
      }
    }
  }

  assert {
    condition     = output.name == "docker-test"
    error_message = "Secret name output should match the configured name"
  }

  assert {
    condition     = jsondecode(kubernetes_secret.docker.data[".dockerconfigjson"]).auths["docker.reg"].username == "USER"
    error_message = "Registry username should be USER"
  }

  assert {
    condition     = jsondecode(kubernetes_secret.docker.data[".dockerconfigjson"]).auths["docker.reg"].password == "PASS"
    error_message = "Registry password should be PASS"
  }

  assert {
    condition     = base64decode(jsondecode(kubernetes_secret.docker.data[".dockerconfigjson"]).auths["docker.reg"].auth) == "USER:PASS"
    error_message = "Registry auth should decode to USER:PASS"
  }
}
