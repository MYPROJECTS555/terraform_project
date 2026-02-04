provider "aws" {
  region = "eu-north-1"
}

module "s3_terraform" {
  source = "./modules/s3"

  bucket = "terraformstate-2-save-s3"
}
module "dynamodb_lock" {
  source     = "./modules/Dynomo-DB"
  table_name = "eks-prod-locks"

  tags       = {
     Name        = "tf-statefile-lock"  # ← Your custom Name tag
    Environment = "prod"
    Team        = "devops"
    Purpose     = "TerraformStateLocking"
  }
}