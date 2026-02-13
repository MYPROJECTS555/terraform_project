# Configure AWS provider with Vault credentials
provider "aws" {
  region     = "eu-north-1"
  access_key = data.vault_kv_secret_v2.aws_creds.data["access_key"]
  secret_key = data.vault_kv_secret_v2.aws_creds.data["secret_key"]
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = "073a5f1b-c12a-3e97-c346-e55b57185a73"
      secret_id = "365b2218-cb2b-715a-aa66-a80f8eefc0a1"
    }
  }
}

# Read AWS credentials from Vault
data "vault_kv_secret_v2" "aws_creds" {
  mount = "my-kv"
  name  = "aws-creds"
}

# Read test secret for tags
data "vault_kv_secret_v2" "test_secret" {
  mount = "my-kv"
  name  = "test-secret"
}



# Dynamic AMI lookup (your hardcoded AMI may be invalid)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2_machine" {
  ami                         = data.aws_ami.amazon_linux.id  # Dynamic AMI
  instance_type               = "t3.micro"
  key_name                    = "private_key_1"
  subnet_id                   = "subnet-05f973f80a70bb562"
  vpc_security_group_ids      = ["sg-0b2b0524eec30c007f"]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 16
    volume_type = "gp2"
  }

  tags = {
    Name = data.vault_kv_secret_v2.test_secret.data["vikas"]  # From Vault it is like username
  }
}

output "instance_public_ip" {
  value = aws_instance.ec2_machine.public_ip
}


