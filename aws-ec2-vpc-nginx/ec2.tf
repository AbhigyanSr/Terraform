resource "aws_instance" "ec2-instance" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [ aws_security_group.nginx-sg ]
  associate_public_ip_address = true
  user_data     = <<-EOF
 #!/bin/bash
 sudo yum install nginx -y
 sudo systemctl start nginx
    EOF
  tags = {
    Name = "Nginx-Server"
  }

}
