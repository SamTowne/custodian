resource "aws_cloudwatch_log_group" "cloud_custodian_scheduler" {
  name              = "/aws/lambda/cloud_custodian_scheduler"
  retention_in_days = 90
}

resource "aws_lambda_function" "cloud_custodian_scheduler" {
  function_name = "cloud_custodian_scheduler"
  role          = module.lambda-iam.processor_role_arn
  publish       = true
  handler       = "listener.listener"
  runtime       = "python3.9"
  description   = "cloud_custodian_scheduler"
  memory_size   = "128"
  timeout       = "300"
  s3_bucket     = aws_s3_bucket.cloud_custodian_lambda_packages.bucket
  s3_key        = "lambda_packages/cloud_custodian_scheduler/app.zip"
}

resource "aws_lambda_alias" "cloud_custodian_scheduler" {
  name             = "cloud_custodian_scheduler"
  description      = "Alias for cloud_custodian_scheduler lambda function"
  function_name    = aws_lambda_function.cloud_custodian_scheduler.arn
  function_version = aws_lambda_function.cloud_custodian_scheduler.version
}