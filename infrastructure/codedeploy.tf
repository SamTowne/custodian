module "processor_deploy" {
  source = "./modules/lambda_codedeploy"

  app_name              = "cloud-custodian-processor"
  service_role_arn      = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRoleForLambda"
  deployment_group_name = "cloud-custodian-processor"
  tags                  = local.tags
}