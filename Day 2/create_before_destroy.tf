resource "local_file" "pet"{
  filename = "/root/pets.txt"
  content = "We love pets"
  file_permission = "0700"

  lifecycle {
    create_before_destroy = true
  }
}
