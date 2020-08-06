resource "aws_api_gateway_rest_api" "contact_api_gateway" {
  name        = var.api_gateway_name
  description = "API for submitting contact requests"
}

resource "aws_api_gateway_model" "MyDemoModel" {
  rest_api_id  = aws_api_gateway_rest_api.MyDemoAPI.id
  name         = "user"
  description  = "a JSON schema"
  content_type = "application/json"

  schema = var.swagger_spec
}