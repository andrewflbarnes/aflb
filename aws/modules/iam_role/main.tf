provider "aws" {
  alias = "region"
}

resource "aws_iam_role" "contact_role" {
  provider           = aws.region
  name               = var.role_name
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

data "aws_iam_policy" "contact_policy_AWSLambdaExecute" {
  provider = aws.region
  arn      = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "contact_policy_ses" {
  provider    = aws.region
  name        = var.policy_name
  path        = "/"
  description = "policy for sending emails over SES"
  policy      = <<EOF
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

resource "aws_iam_role_policy_attachment" "contact_policy_attachment_ses" {
  provider   = aws.region
  role       = aws_iam_role.contact_role.name
  policy_arn = aws_iam_policy.contact_policy_ses.arn
}

resource "aws_iam_role_policy_attachment" "contact_policy_attachment_AWSLambdaExecute" {
  provider   = aws.region
  role       = aws_iam_role.contact_role.name
  policy_arn = data.aws_iam_policy.contact_policy_AWSLambdaExecute.arn
}