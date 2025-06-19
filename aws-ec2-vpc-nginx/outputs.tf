output "instance_public_id"{
    description = "The public IP address of the EC2 instance"
    value = aws_instance.ec2-instance.public_ip
}

output "instance_url" {
  description = "The URL to access the Nginx server"
  value ="https://${aws_instance.ec2-instance.public_ip}"
}