# terraform-kubernetes-docker-secret [![tests workflow status](https://github.com/bendrucker/terraform-kubernetes-docker-secret/workflows/tests/badge.svg?branch=master)](https://github.com/bendrucker/terraform-kubernetes-docker-secret/actions?query=workflow%3Atests) [![terraform module](https://img.shields.io/badge/terraform-module-623CE4)](https://registry.terraform.io/modules/bendrucker/docker-secret/kubernetes)

> Terraform module that creates a [Kubernetes Docker secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)

## Usage

```tf
module "image_pull_secret" {
  name      = "dockerhub"
  namespace = "default"

  registries = {
    "https://index.docker.io/v1/" = {
      username = "user"
      password = "password"
      email = null
    }
  } 
}
```

## Testing

```sh
minikube start
go test -v ./...
```

## License

MIT © [Ben Drucker](http://bendrucker.me)
