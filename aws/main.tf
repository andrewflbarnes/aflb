provider "aws" {
  alias   = "region"
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

  providers = {
    aws.region = aws.region
  }
}

module "lambda" {
  source = "./modules/lambda_ses"

  providers = {
    aws.region = aws.region
  }

  lambda_source = var.lambda_source
  iam_role_arn  = module.iam_role.iam_role_arn
  email_to      = var.email_to
  email_from    = var.email_from
}

module "api" {
  source = "./modules/api_gateway"

  providers = {
    aws.region = aws.region
  }

  stage                        = var.stage
  contact_lambda_function_name = module.lambda.contact_lambda_function_name
  contact_lambda_invoke_arn    = module.lambda.contact_lambda_invoke_arn
  swagger_spec                 = var.swagger_spec
}