terraform {
  backend "s3" {
    bucket  = "terraform-state-sfbjj"
    key     = "infra/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}

