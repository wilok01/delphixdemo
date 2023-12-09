terraform {
  cloud {
    organization = "wokosun"

    workspaces {
      name = "test"
    }
  }
}

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
  region = "us-east-2"
}

# Configure the AWS Provider
provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}
