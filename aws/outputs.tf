output "dns_entries" {
  value       = module.cert.dns_entries
  description = "The DNS entries required in order for domain validation to pass - use when the domain is managed externally"
}

output "cert_arn" {
  value       = module.cert.cert_arn
  description = "The ARN of the certificate created for the API Gateway custom domain"
}