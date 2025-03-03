
variable "filename" {
   default = "/root/pets.txt"
}

variable "content" {
   default = "We love pets"
}

# accessing the above varaibles in main.tf as below
resource "local_file" "pet" {
   filename = var.filename
   content  = var.content
}
