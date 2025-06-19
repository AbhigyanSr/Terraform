terraform{
    required_providers{
        aws ={
            source="hashicorp/aws"
            version="5.54.1"
        }
    }
}

provider "aws"{
    region = var.region
}

resource "aws_instance" "webserver-1" {
    ami = "ami-020cba7c55df1f615" # Aws ubuntu ami id
    instance_type = "t2.micro"
    tags ={
        name="meow meoww"
    }
}