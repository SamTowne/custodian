module "lambda-iam" {
  source                   = "./modules/lambda-iam"
  processor_log_group_name = "aws/lambda/cloud_custodian_processor_${var.env}"
  scheduler_log_group_name = "aws/lambda/cloud_custodian_scheduler_${var.env}"
  configurator_log_group_name = "aws/lambda/cloud_custodian_configurator_${var.env}"
  env = var.env
}
