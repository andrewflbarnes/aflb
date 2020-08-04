terraform {
  backend "s3" {
    bucket = "aflb-terraform-state"
    key    = "aflb-contact-email/terraform.tfstate"
    region = "eu-west-2"
  }
}
