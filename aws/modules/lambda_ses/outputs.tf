output "contact_lambda" {
  value       = aws_lambda_function.contact_lambda.arn
  description = "The arn for the Lambda function createdsend email over SES"
}