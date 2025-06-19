terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = "ap-south-1"
}

#Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}
#Private subnet
resource "aws_subnet" "my-private-subnet" {
  cidr_block = "10.0.0.0/16"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name = " My-Private-Subnet"
  }
}

#Public Subnet
resource "aws_subnet" "my-public-subnet" {
  cidr_block = "10.0.0.0/16"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name = " My-Public-Subnet"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

#Routing Table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

}

#Associating route table with public subnet
resource "aws_route_table_association" "rt-pub-sub" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.my-public-subnet.id
  
}