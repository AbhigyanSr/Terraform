#tf file for output variables for the AWS EC2 module
output "ec2_instance_public_ip" {
    value = aws_instance.webserver-1.public_ip
    description = "Public IP of the EC2 instance"
  
}