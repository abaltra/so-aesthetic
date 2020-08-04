
resource "aws_cloudwatch_event_rule" "aesthetic_cw_event" {
  name                = "send-inspo"
  description         = "Tweets inspiration quotes every 24 hrs"
  schedule_expression = "cron(0 22 * * ? *)"
}

resource "aws_cloudwatch_event_target" "tweet_every_day" {
  rule      = aws_cloudwatch_event_rule.aesthetic_cw_event.name
  target_id = "lambda"
  arn       = aws_lambda_function.aesthetic_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aesthetic_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.aesthetic_cw_event.arn
}