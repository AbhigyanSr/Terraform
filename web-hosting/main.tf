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

provider "aws" {
  region = var.region
}

resource "random_id" "rand_int" {
  byte_length = 3
}

resource "aws_s3_bucket" "bucket" {
  bucket = "webhostingbucket${random_id.rand_int.hex}"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "websiteconfig" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
  acl          = "public-read"
}

resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.bucket.bucket
  key          = "style.css"
  source       = "./style.css"
  content_type = "text/css"
  acl          = "public-read"
}

output "webendpoint" {
  value = aws_s3_bucket_website_configuration.websiteconfig.website_endpoint
}
