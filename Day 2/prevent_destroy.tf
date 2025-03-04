resource "local_file" "pet" {
  filename = "/root/pets.txt"
  content = "We lova pets!"
  file_permission ="0700"

  lifecycle {
    prevent_destroy=true
  }
}
