variable "region" {
  description = "value of the region"
  type = string
  default = "eu-north-1"
}
variable "table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "terraform-locks"
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}