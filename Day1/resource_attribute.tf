resource "local_file" "pet" {
   filename = var.filename
   content  = "My favourite pet is ${}
}


resource "random_pet" "my-pet"{
   prefix = var.prefix
   separator = var.separator
   length = var.length
}
