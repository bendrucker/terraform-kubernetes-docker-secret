output "name" {
  description = "The name of the secret"
  value       = kubernetes_secret.docker.metadata[0].name
}

output "data" {
  description = "The secret data"
  value       = kubernetes_secret.docker.data
  sensitive   = true
}