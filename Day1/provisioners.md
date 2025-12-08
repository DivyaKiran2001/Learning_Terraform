# Terraform Provisioners

Provisioners allow Terraform to **execute commands or scripts after a resource is created or destroyed**. They can be used to:

- Run bootstrap or setup commands
- Upload configuration files
- Execute deployment steps
- Perform post-creation configuration

Provisioners should be used **only when no better alternative exists**, because they can introduce lifecycle unpredictability.

---

# Why Use Provisioners?

Provisioners are useful for:
- Configuring servers immediately after creation
- Uploading or generating configuration files
- Installing software packages
- Running deployment scripts
- Triggering external systems

---

# Types of Provisioners

Terraform supports **three commonly used provisioners**:

1. `local-exec`
2. `remote-exec`
3. `file`

Each has different purposes depending on where commands run and what they do.

---

# 1. local-exec Provisioner

### Purpose:
Runs a command **locally** on the system where Terraform is executed.

### Usage Example:
```hcl
resource "aws_instance" "app" {
  ami           = "ami-1234567890abcdef0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo Instance created with ID: ${self.id}"
  }
}
```

**2. remote-exec Provisioner**
**Purpose:**

```
resource "aws_instance" "web" {
  ami           = "ami-1234567890abcdef0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
```

**3. file Provisioner**

**Purpose:**

Uploads a file or directory from local machine to a remote server.

```
resource "aws_instance" "app" {
  ami           = "ami-1234567890abcdef0"
  instance_type = "t2.micro"

  provisioner "file" {
    source      = "config.json"
    destination = "/tmp/config.json"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
```
