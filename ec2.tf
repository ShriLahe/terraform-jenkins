terraform {
  backend "s3" {
    bucket = "terraformmy4344"
    key    = "files1/"
    region = "us-east-1"
  }
}

provider "aws" {
region = "ap-south-1"

}
resource "aws_instance" "web" {
  ami           = ami-09ba48996007c8b50
  instance_type = "t2.micro"
  user_data = <<EOF
		#!/bin/bash
		yum update -y
		yum install -y httpd.x86_64
		systemctl start httpd.service
		systemctl enable httpd.service
		echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  EOF
  tags = {
    Name = "HelloWorld"
  }
}
