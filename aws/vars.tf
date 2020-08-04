variable "email_to" {
  type        = string
  description = "The email address notifications should be sent to"
}

variable "email_from" {
  type        = string
  description = "The email address notifications should be sent from"
}

variable "region" {
  type        = string
  description = "The region to provision the resources in and to configure the SES integration with"
}