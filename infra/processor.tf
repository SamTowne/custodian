# resource "aws_cloudwatch_log_group" "cloud_custodian_processor" {
#   name              = "/aws/lambda/cloud_custodian_processor_${var.env}"
#   retention_in_days = 90
# }

# resource "aws_lambda_function" "cloud_custodian_processor" {
#   function_name = "cloud_custodian_processor_${var.env}"
#   role          = module.lambda-iam.processor_role_arn
#   publish       = true
#   handler       = "listener.listener"
#   runtime       = "python3.9"
#   description   = "cloud_custodian_processor"
#   memory_size   = "128"
#   timeout       = "300"
#   s3_bucket     = aws_s3_bucket.cloud_custodian_lambda_packages.bucket
#   s3_key        = "lambda_packages/processor/app.zip"
# }

# resource "aws_lambda_alias" "cloud_custodian_processor" {
#   name             = "cloud_custodian_processor"
#   description      = "Alias for cloud_custodian_processor lambda function"
#   function_name    = aws_lambda_function.cloud_custodian_processor.arn
#   function_version = aws_lambda_function.cloud_custodian_processor.version
# }