#################
### Bootstrap ###
#################

# Build an S3 bucket and DynamoDB for Terraform state and locking
module "bootstrap" {
  source         = "../modules/bootstrap"
  project_prefix = "custodian-272773485930"
}

# Build the IAM needed for github actions CICD
# **IMPORTANT** Configuring this part incorrectly can compromise your AWS account, don't touch this unless you are comfortable with OIDC and federation concepts.
module "github-actions-iam" {
  source           = "../modules/github-actions-iam"
  project_prefix   = "custodian-272773485930"
  github_workspace = "SamTowne"
  github_repo      = "custodian"
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
    }
  }
}

# Backend is determined during Github Actions workflow based upon branch
# main = production environment
# dev = dev environment
terraform {
  backend "s3" {
    bucket         = "custodian-272773485930-terraform-tfstate"
    key            = "core/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "custodian-272773485930-dynamodb-terraform-locking"
    encrypt        = true
  }
}