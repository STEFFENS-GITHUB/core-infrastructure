provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    key          = "backend/core/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}