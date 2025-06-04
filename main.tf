provider "aws" {
    region = "eu-north-1"
    access_key = " "
    secret_key = " "
}
resource "aws_instance" "ec2" {
    ami = "ami-0c1ac8a41498c1a9c"
    instance_type = "t3.medium"
    key_name = "private_key_1"
    subnet_id = "subnet-0ab3aadf95217a62c"
    associate_public_ip_address = true 
    root_block_device{
        volume_size = 16
        volume_type ="gp2"
    }
    user_data = file("script.sh")
    tags = {
        Name = "ec2_by_terraform"
    }
}