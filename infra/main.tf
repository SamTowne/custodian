############################
### Terraform S3 Backend ###
############################
# Backend is determined during Github Actions workflow based upon branch
# main = production environment
# dev = dev environment
terraform {
  backend "s3" {
  }
}

#################
### Providers ###
#################

# Credentials / auth is done via the infra/core configuration and uses OIDC between AWS & github

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