resource "aws_eip" "web_server_eip" { 
instance = var.instance_id 
tags = { 
Name = "web-server-eip" 
} 
}
