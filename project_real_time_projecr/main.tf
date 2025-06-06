provider "aws"{
    region = "eu-north-1"
}
resource "aws_instance" "ec2" {
    ami = "ami-006b4a3ad5f56fbd6"
    instance_type = "t3.micro"
    key_name = "private_key_1"
    subnet_id = "subnet-0ab3aadf95217a62c"
    vpc_security_group_ids = ["sg-0937d86d5ba835424"]
    associate_public_ip_address = true 
    root_block_device{
        volume_size = 8
        volume_type ="gp2"
    }
    tags = {
        Name = "JENKINS_TERRAFORM_INT"
    }
}
