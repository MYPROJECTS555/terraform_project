provider "aws" {
  region = "eu-north-1" # References the variable
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
  ami                      = "ami-04233b5aecce09244"
  instance_type            = "t3.micro"
  subnet_id                = "subnet-04b43d08ac0942db3"
  key_name                 = "private_key_ec2"
  vpc_security_group_ids   = ["sg-0b2b0524eec30c007"]
}