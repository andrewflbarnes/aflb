output "api_invoke_url" {
  value       = aws_api_gateway_deployment.contact_api_deployment.invoke_url
  description = "The base path of the URL to invoke for the API gateway"
}