resource "aws_cloudwatch_log_group" "cloud_custodian_configurator" {
  name              = "/aws/lambda/cloud_custodian_configurator"
  retention_in_days = 90
}

resource "aws_lambda_function" "cloud_custodian_configurator" {
  function_name = "cloud_custodian_configurator"
  role          = module.lambda-iam.processor_role_arn
  publish       = true
  handler       = "listener.listener"
  runtime       = "python3.9"
  description   = "cloud_custodian_configurator"
  memory_size   = "128"
  timeout       = "300"
  s3_bucket     = aws_s3_bucket.cloud_custodian_lambda_packages.bucket
  s3_key        = "lambda_packages/cloud_custodian_configurator/app.zip"
}

resource "aws_lambda_alias" "cloud_custodian_configurator" {
  name             = "cloud_custodian_configurator"
  description      = "Alias for cloud_custodian_configurator lambda function"
  function_name    = aws_lambda_function.cloud_custodian_configurator.arn
  function_version = aws_lambda_function.cloud_custodian_configurator.version
}