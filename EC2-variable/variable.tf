
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for instance placement"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}
