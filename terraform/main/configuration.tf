terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }
}
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::590183900117:role/TerrafromAccess"
  }
  region = "us-west-2"
}

