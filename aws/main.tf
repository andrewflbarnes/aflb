provider "aws" {
  profile = "default"
  region  = var.region
}

terraform {
  backend "s3" {
    bucket = "aflb-terraform-state"
    key    = "aflb-contact-email/terraform.tfstate"
    region = "eu-west-2"
  }
}

module "iam_role" {
  source = "./modules/iam_role"
}

module "lambda" {
  source = "./modules/lambda_ses"

  lambda_source = var.lambda_source
  iam_role_arn  = module.iam_role.iam_role_arn
  email_to      = var.email_to
  email_from    = var.email_from
  region        = var.region
}