variable "registries" {
  type = map(object({
    username = string
    password = string
    email    = string
  }))

  description = "Map of registry hostnames to credentials. Email is optional and will be omitted if empty/null."
}

variable "name" {
  type        = string
  description = "Name of the Kubernetes secret that will be created"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace where the secret will be created"
}
