provider "aws" {
  alias = "region"
}

data "aws_region" "current" {
  provider = aws.region
}

resource "aws_lambda_function" "contact_lambda" {
  provider         = aws.region
  filename         = var.lambda_source
  function_name    = var.lambda_name
  role             = var.iam_role_arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(var.lambda_source)
  runtime          = "nodejs12.x"
  environment {
    variables = {
      email_to   = var.email_to
      email_from = var.email_from
      region     = data.aws_region.current.name
    }
  }
}