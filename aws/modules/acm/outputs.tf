output "dns_entries" {
  value       = aws_acm_certificate.cert.domain_validation_options
  description = "The DNS entries required in order for domain validation to pass - use when the domain is managed externally"
}

output "cert_arn" {
  value       = aws_acm_certificate.cert.arn
  description = "The ARN of the generated certificate"
}