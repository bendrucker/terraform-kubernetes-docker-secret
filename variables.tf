variable "registries" {
  type = map(object({
    username = string
    password = string
  }))

  description = "Map of registry hostnames to credentials (username, password)."
}

variable "name" {
  type        = string
  description = "Name of the Kubernetes secret that will be created"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace where the secret will be created"
}
