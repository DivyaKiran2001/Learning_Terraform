provider "aws" {
  region = "us-west-1"
}


resource "aws_instance" "webserver"{
  ami = "ami-0edsfbvnmj..........'
  instance_type = "t2.micro"
  tags = {
    Name ="webserver"
    Description = "A web server"
  }
  user_data = << EOF 
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              EOF
}
