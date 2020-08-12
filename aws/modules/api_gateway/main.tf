provider "aws" {
  alias = "region"
}

resource "aws_api_gateway_rest_api" "contact_api_gateway" {
  provider    = aws.region
  name        = var.api_gateway_name
  description = "API for submitting contact requests"
  body = templatefile(var.swagger_spec, {
    contact_lambda_invoke_arn = var.contact_lambda_invoke_arn
  })
  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  provider      = aws.region
  statement_id  = "AllowContactLambdaInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.contact_lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/ allows invocation from any stage
  source_arn = "${aws_api_gateway_rest_api.contact_api_gateway.execution_arn}/*/POST/contact"
}

resource "aws_api_gateway_deployment" "contact_api_deployment" {
  provider    = aws.region
  rest_api_id = aws_api_gateway_rest_api.contact_api_gateway.id
  stage_name  = var.stage

  triggers = {
    redeployment = sha1(join(",", list(
      jsonencode(aws_api_gateway_rest_api.contact_api_gateway.body),
    )))
  }

  lifecycle {
    create_before_destroy = true
  }
}