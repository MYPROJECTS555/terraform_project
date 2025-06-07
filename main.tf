provider "aws" {
    region = "eu-north-1"
    access_key = "KIA5CBGTJDEEQ67UIEI"
    secret_key = "e2z1k672krxO+6jJMgeO6PtaAGLLsZoy+SpP+wD"  // we are lanching the instance form local 
}
resource "aws_instance" "ec2" {
    ami = "ami-05d3e0186c058c4dd"
    instance_type = "t3.medium"
    key_name = "private_key_1"
    subnet_id = "subnet-0ab3aadf95217a62c"
    vpc_security_group_ids = ["sg-0937d86d5ba835424"]
    associate_public_ip_address = true
   
    root_block_device{
        volume_size = 16
        volume_type = "gp2"
    }
    user_data = file("shell.sh")
    tags = {
        Name = "ec2_by_terraform"
    }

}
