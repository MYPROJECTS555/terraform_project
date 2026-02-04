resource "aws_s3_bucket" "s3_terraform" {
  bucket = var.bucket

  tags = {
    Name        = "terraform-project"
   }
}
resource "aws_s3_bucket_public_access_block" "s3_terraform" {
  bucket = aws_s3_bucket.s3_terraform.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_versioning" "s3_terraform" {
  bucket = aws_s3_bucket.s3_terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}