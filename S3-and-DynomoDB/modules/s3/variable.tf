variable "region" {
  description = "value of the region"
  type = string
  default = "eu-north-1"
}
variable "bucket" {
  description = "S3 bucket name (must be globally unique)"
  type        = string
}