variable "policy_name" {
  type        = string
  description = "The name to give the IAM policy which allows sending emails over SES"
  default     = "email_contact_policy_ses"
}

variable "role_name" {
  type        = string
  description = "The name to give the role created"
  default     = "email_contact_role"
}