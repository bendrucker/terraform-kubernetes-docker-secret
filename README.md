# terraform-kubernetes-docker-secret [![terraform workflow status](https://github.com/bendrucker/terraform-kubernetes-docker-secret/workflows/terraform/badge.svg?branch=master)](https://github.com/bendrucker/terraform-kubernetes-docker-secret/actions?query=workflow%3Aterraform)

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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| kubernetes | ~> 1 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | ~> 1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Kubernetes secret that will be created | `string` | n/a | yes |
| namespace | Kubernetes namespace where the secret will be created | `string` | n/a | yes |
| registries | Map of registry hostnames to credentials. Email is optional and will be omitted if empty/null. | <pre>map(object({<br>    username = string<br>    password = string<br>    email    = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| data | The secret data |
| name | The name of the secret |

## Testing

```sh
minikube start
go test -v ./...
```

## License

MIT © [Ben Drucker](http://bendrucker.me)
