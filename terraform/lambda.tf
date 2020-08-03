resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_lambda_function" "aesthetic_lambda" {
  filename      = "${path.root}/../dist/function.zip"
  function_name = "so-aesthetic"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main.handler"

  source_code_hash = filebase64sha256("${path.root}/../dist/function.zip")

  runtime = "python3.8"
  timeout = 60

  environment {
    variables = {
      TWITTER_CONSUMER_KEY = var.TWITTER_CONSUMER_KEY,
      TWITTER_CONSUMER_SECRET = var.TWITTER_CONSUMER_SECRET,
      TWITTER_ACCESS_TOKEN = var.TWITTER_ACCESS_TOKEN,
      TWITTER_ACCESS_TOKEN_SECRET = var.TWITTER_ACCESS_TOKEN_SECRET
    }
  }
}