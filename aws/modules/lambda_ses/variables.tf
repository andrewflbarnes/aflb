variable "lambda_name" {
  type        = string
  description = "The name to give the lambda function created"
  default     = "email_contact_lambda"
}

variable "lambda_source" {
  type        = string
  description = "The name of the zip file containing the source code"
}

variable "email_to" {
  type        = string
  description = "The email address notifications should be sent to"
}

variable "email_from" {
  type        = string
  description = "The email address notifications should be sent from"
}

variable "iam_role_arn" {
  type        = string
  description = "The arn for the role which the lambda executes under - must have Lambda execution and SES send email"
}