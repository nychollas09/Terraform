terraform {
  required_version = "1.2.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }

  backend "s3" {
    bucket = "terraform-state-dgvycmfmb3jtlxn0yxrlcg"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
