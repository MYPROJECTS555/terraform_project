terraform {
  backend "s3" {
    bucket         = "terraformstate-2-save-s3"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
  
    encrypt        = true
  }
}