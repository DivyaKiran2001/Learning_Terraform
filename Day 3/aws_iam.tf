provider "aws" {
  region = "us-west-2"
  access_key = ""
  secret_key = ""
}


resource "aws_iam_user" "admin-user" {
  name = "lucy"
  tags ={
    Description = "Technical Team Leader"
  }
}
