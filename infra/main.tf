# Quick setup:
#  1. Replace all instances of custodian with the name of the project
#  2. Replace all instances of 272773485930 with the AWS Account ID in use
#  3. Replace all instances of us-west-2 with the AWS region to deploy to

#################
### Bootstrap ###
#################

# Build an S3 bucket and DynamoDB for Terraform state and locking
module "bootstrap" {
  source         = "./modules/bootstrap"
  project_prefix = "custodian-272773485930"
}

# Build the IAM needed for github actions CICD
# **IMPORTANT** Configuring this part incorrectly can compromise your AWS account, don't touch this unless you are comfortable with OIDC and federation concepts.
module "github-actions-iam" {
  source           = "./modules/github-actions-iam"
  project_prefix   = "custodian-272773485930"
  github_workspace = "SamTowne"
  github_repo      = "custodian"
}

############################
### Terraform S3 Backend ###
############################
# This should be commented out for the first terraform apply so that the tfstate bucket and locking table can be built. After the initial apply, uncomment the s3 backend code and run another apply.
terraform {
  backend "s3" {
  }
}

#################
### Providers ###
#################

# Credentials are exported or retrieve from an external store like Hashicorp Vault

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Terraform = "true"
      Project   = "custodian"
      Environment = var.env
    }
  }
}

locals {
  project_suffix = "${var.env}-custodian-272773485930"
  env = var.env
}