provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "terraform-cloudfromscratch"
    key     = "state/cfs/terraform_cfs.tfstate"
    region  = "us-east-1"
  }
}