terraform {
  required_version = ">= 1.3"
}

provider "aws" {
  region = "eu-north-1"
  access_key = ""
  secret_key = ""
}

module "vpc" {
  source = "./modules/vpc"  // it will take value from vpc inside the modules folder

  vpc_cidr        = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}


/*

modules/
  vpc/
    main.tf
    variables.tf
    outputs.tf

*/