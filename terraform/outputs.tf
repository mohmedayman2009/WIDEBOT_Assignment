# Output the application URL
output "app_url" {
  description = "The URL of the application"
  value       = "https://${kubernetes_ingress.app.spec[0].rules[0].host}"
}
