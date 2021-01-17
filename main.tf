terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  profile     = "default"
  region      = var.region
}

#----------------------------
# Configure modules
#----------------------------
module "aws_lambda_function" {
  source            = "./modules/lambda"
  project           = var.project
  env               = var.env
  core_lambda_names = var.core_lambda_names
}
