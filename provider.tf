terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "tftester"
  region  = "ap-southeast-1"
  default_tags {
    tags = {
      "Managed by" = "Terraform"
    }
  }
}
