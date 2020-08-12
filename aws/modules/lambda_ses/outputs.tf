output "contact_lambda_invoke_arn" {
  value       = aws_lambda_function.contact_lambda.invoke_arn
  description = "The invocation arn for the Lambda function created"
}

output "contact_lambda_function_name" {
  value       = aws_lambda_function.contact_lambda.function_name
  description = "The invocation arn for the Lambda function created"
}