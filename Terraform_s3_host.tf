provider "aws"{
region ="us-east-1"
}
resource "aws-s3-bucket" "mybucket"
{
bucket = " IAMbilloniaratfamily "
tag ={
Name = "myBucket"
}
}
