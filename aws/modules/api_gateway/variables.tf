variable "api_gateway_name" {
  type        = string
  description = "The name to give the API gateway created"
  default     = "contact_api_gateway"
}

variable "swagger_spec" {
  type        = string
  description = "The name of the file containing the swagger spec"
}

variable "contact_lambda_invoke_arn" {
  type        = string
  description = "The invoke arn of the lambda function to call on the POST contact API"
}

variable "contact_lambda_function_name" {
  type        = string
  description = "The name of the lambda function to call on the POST contact API"
}

variable "stage" {
  type        = string
  description = "The name of the stage to deploy the API to"
}