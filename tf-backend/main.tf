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
# Backend configuration used here is for storing state in S3 to ensure better collaboration and consistency
backend "s3" {
  bucket         = "demo1bucketd09f133b4dfad764"
  key            = "backend.tfstate"
  region         = "ap-south-1"
}
}

resource "random_id" "rand_id" {
    byte_length=8
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myserver" {
   ami = "ami-0f918f7e67a3323f0" # Aws ubuntu ami id
   instance_type = "t2.micro"
    tags ={
        Name="myserver${random_id.rand_id.hex}"
    }
}
