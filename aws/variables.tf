variable "region" {
  type        = string
  description = "The region to provision the resources in and to configure the SES integration with"
}

variable "stage" {
  type        = string
  description = "The name of the stage to deploy the API to"
}

variable "email_to" {
  type        = string
  description = "The email address notifications should be sent to"
}

variable "email_from" {
  type        = string
  description = "The email address notifications should be sent from"
}

variable "lambda_source" {
  type        = string
  description = "The location of the zip file containing the lambda source"
  default     = "contact_lambda.zip"
}

variable "swagger_spec" {
  type        = string
  description = "The location of the file containing the swagger yaml source"
  default     = "swagger.yml"
}

variable "domain" {
  type        = string
  description = "The domain to expose the API gateway on"
}