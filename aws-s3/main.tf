terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.54.1"
        }
        random = {
            source  = "hashicorp/random"
            version = "3.5.1"
        }
    }
}
provider aws {
    region = var.region
}

resource "aws_s3_bucket" "demo1bucket1"{
    bucket = "demo1bucket${random_id.rand_id.hex}"
}
resource "random_id" "rand_id" {
    byte_length = 8
  
}
# resource "aws_s3_object" "bucket-data" {
#   bucket       = aws_s3_bucket.demo1bucket1.bucket
#   key          = "file1.txt"
#   source       = "./main.txt"
#   content_type = "text/plain"
# }
