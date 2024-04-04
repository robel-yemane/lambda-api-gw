
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      tf-cloud-learn = "lambda-api-gateway"
    }
  }
  #  removed for tf cloud
  #  profile = "cs"
}