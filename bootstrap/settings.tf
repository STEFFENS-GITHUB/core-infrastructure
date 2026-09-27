provider "aws" {
  region  = "us-east-1"
}

provider "aws" {
  alias   = "root"
  region  = "us-east-1"
  profile = "root"
}

terraform {
  backend "s3" {
    key          = "backend/bootstrap/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}