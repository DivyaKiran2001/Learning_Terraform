# Terraform Provisioners

Terraform Provisioners are used to execute scripts or commands on a local or remote machine as part of a resource deployment process. They allow you to customize infrastructure by executing actions after a resource is created or destroyed.

## Remote-Exec Provisioner

The Remote-Exec Provisioner runs commands on the remote machine after it's created.

```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
}
```

## Local-Exec Provisioner

The Local-Exec Provisioner runs commands on the machine executing Terraform (your local system).

```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ip.txt"
  }
}
```

# Terraform State Locking

Terraform state locking is a mechanism that prevents multiple users or processes from modifying the Terraform state file (`terraform.tfstate`) at the same time. This ensures data consistency and avoids conflicts when multiple team members or automation pipelines are running Terraform commands concurrently.

# Terraform State Commands

- `terraform state list` - Lists all managed resources in the state.
- `terraform state show <resource>` - Displays detailed information about a specific resource in the state.
- `terraform state mv <source> <destination>` - Moves a resource to a new location in the state.
- `terraform state rm <resource>` - Removes a resource from the state file (without destroying it).
- `terraform state pull` - Downloads and displays the current state file.
- `terraform state push` - Uploads a modified state file (deprecated, rarely used).

# Terraform Import

`terraform import` allows you to bring existing infrastructure (created outside Terraform) into your Terraform state without recreating or modifying the resource.

**Syntax:**
```sh
terraform import <resource_type>.<resource_name> <resource_id>
```

# Terraform Modules

A Terraform module is a reusable, self-contained set of Terraform configuration files that can be used to manage infrastructure. Modules help in organizing, reusing, and scaling Terraform code.

## Types of Terraform Modules

1. **Root Module** - The main module where you define resources (e.g., `main.tf`).
2. **Child Modules** - Additional modules stored in separate directories or external sources.

### Example:

```hcl
module "dev-webserver"{
   source = "../aws-instance"
}
```

# Terraform Functions

Terraform provides built-in functions to manipulate data within configurations. These functions help with string manipulation, arithmetic operations, data conversions, and more.

## Categories of Terraform Functions

### 1. String Functions:

- `upper()`
- `lower()`
- `length()`
- `substr()`
- `replace()`
- `trimspace()`

### 2. Numeric Functions:

- `abs()`
- `max()`
- `min()`
- `ceil()`
- `floor()`
- `round()`

### 3. Collection Functions:

- `length()`
- `contains()`
- `join()`
- `split()`
- `toset()`
- `merge()`

# Terraform Conditional Expressions

Terraform supports conditional expressions using the ternary operator (`? :`), allowing you to define logic based on conditions.

**Syntax:**
```hcl
condition ? true_value : false_value
