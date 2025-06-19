resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/0"
  tags = {
    Name ="my-vpc"
  }
}

#public subnet
resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags ={
        Name = "my-public-subnet"
    }
  
}

#private subnet
resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags ={
        Name = "my-private-subnet"
    }
  
}

#internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-igw"
    }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

#Associating route table with public subnet
resource "aws_route_table_association" "rt-pub-sub" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.public-subnet.id
  
}