variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public subnet CIDR"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Private subnet CIDR"
}
