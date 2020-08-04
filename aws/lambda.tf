resource "aws_iam_role" "aflb_contact_role" {
  name = "aflb_contact_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy" "aflb_contact_policy_AWSLambdaExecute" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "aflb_contact_policy_ses" {
  name        = "aflb_contact_policy_ses"
  path        = "/"
  description = "aflb_contact policy for sending emails over SES"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": [
            "ses:SendEmail",
            "ses:SendRawEmail"
        ],
        "Effect": "Allow",
        "Resource": "*",
        "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aflb_contact_policy_attachment_ses" {
  role       = aws_iam_role.aflb_contact_role.name
  policy_arn = aws_iam_policy.aflb_contact_policy_ses.arn
}

resource "aws_iam_role_policy_attachment" "aflb_contact_policy_attachment_AWSLambdaExecute" {
  role       = aws_iam_role.aflb_contact_role.name
  policy_arn = data.aws_iam_policy.aflb_contact_policy_AWSLambdaExecute.arn
}

resource "aws_lambda_function" "aflb_contact_lambda" {
  filename      = "aflb_contact_lambda.zip"
  function_name = "aflb_contact_lambda"
  role          = aws_iam_role.aflb_contact_role.arn
  handler       = "index.handler"

  source_code_hash = filebase64sha256("aflb_contact_lambda.zip")

  runtime = "nodejs12.x"

  environment {
    variables = {
      email_to   = var.email_to
      email_from = var.email_from
      region     = var.region
    }
  }
}