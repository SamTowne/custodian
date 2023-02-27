module "lambda-iam" {
  source                   = "./modules/lambda-iam"
  processor_log_group_name = "aws/lambda/cloud_custodian_processor"
  scheduler_log_group_name = "aws/lambda/cloud_custodian_scheduler"
  dynamodb_updater_log_group_name = "aws/lambda/cloud_custodian_dynamodb_updater"
}