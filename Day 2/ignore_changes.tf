resource "aws_instance" "webserver"{
  ami ="ami-0ertyhtgfdngf8999"
  instance_type="t2.micro"
  tags ={
    Name = "ProjectA-Webserver"
  }
  lifecycle {
    ignore_changes = [
      tags,ami
    ]
  }

}
