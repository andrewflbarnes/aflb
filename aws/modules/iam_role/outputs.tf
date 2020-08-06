output "iam_role_arn" {
  value       = aws_iam_role.contact_role.arn
  description = "The arn for the IAM role created to execute the Lambda with SES send email"
}