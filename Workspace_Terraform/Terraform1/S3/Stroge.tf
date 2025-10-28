provider "aws" {
  region     = "ap-south-1"            # AWS Region (Mumbai)
  access_key = "...."   # Replace with your Access Key
  secret_key = "......."   # Replace with your Secret Key
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "arman-terraform-bucket-12345"

  tags = {
    Name        = "MyTerraformBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
