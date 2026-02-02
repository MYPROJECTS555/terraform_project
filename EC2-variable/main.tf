provider "aws" {
    region = "eu-north-1"
}
resource "aws_instance" "ec2" {  
  ami                      = var.ami
  instance_type            = var.instance_type
  subnet_id                = var.subnet_id
  key_name                 = var.key_name
  vpc_security_group_ids   = var.vpc_security_group_ids  
  associate_public_ip_address = true
  
  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }
  
  tags = { 
    Name = "ec2-server" 
  }
}