provider "aws" {
  profile = "default"
  # Certs have to be under this region when used on custom domains
  region  = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Name = "${var.domain} API Gateway certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}