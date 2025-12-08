# Terraform Basics

## Introduction
Terraform is an **Infrastructure as Code (IaC)** tool that allows you to define and provision infrastructure using a declarative configuration language.

## Key Concepts
- Every object that Terraform manages is called a **Resource**.
- A **Resource** can be an S3 Bucket, Virtual Machine (VM), etc.
- Terraform uses **HashiCorp Configuration Language (HCL)**.

## Stages in Terraform
1. **Init** - Initializes a Terraform working directory.
2. **Plan** - Creates an execution plan to preview changes.
3. **Apply** - Applies the planned changes to provision resources.
4. **Destroy** - Destroys the created resources.

## Terraform Commands
```sh
terraform init    # Initializes Terraform in the working directory
terraform plan    # Previews the changes Terraform will apply
terraform apply   # Applies the changes to create resources
terraform destroy # Destroys all managed resources
```

## Terraform Configuration Syntax
```hcl
<block> <parameters> {
    key1 = value1
    key2 = value2
}
```

### Example Configuration
_File: `sample.tf`_
```hcl
resource "local_file" "pet" {
    filename = "/root/pets.txt"
    content  = "We love pets!"
}
```
- **local** - Provider
- **file** - Resource type
- **pet** - Resource name

## Providers
A **provider** is a plugin that enables Terraform to interact with cloud services like AWS, Azure, Google Cloud, etc.

## Configuration Directory Structure
A typical Terraform configuration consists of the following files:
- `main.tf` - Defines the main infrastructure configuration.
- `variables.tf` - Declares input variables.
- `output.tf` - Specifies output values.
- `provider.tf` - Defines providers and authentication settings.

---
# Terraform Input and Output Variables

## 4. Input Variables

Input variables in Terraform allow you to parameterize configurations and make your infrastructure code more flexible and reusable. Instead of hardcoding values, you define variables that can be assigned different values as needed.

```hcl
variable "variable_name" {
  type        = <type>      # Optional: Defines the data type
  default     = <value>     # Optional: Default value
  description = "Description of the variable"
}
```

### Supported Types:
- `string`
- `number`
- `bool`
- `any`
- `list`
- `map`
- `object`
- `tuple`

### Using Variables
You can use the variables declared in `.tf` files using the syntax:
```hcl
var.variable_name
```

### Passing Variables

#### 1. Interactive Mode
```sh
terraform apply
```
**Example:**
```
var.content
   Enter a value : We love pets
var.filename
   Enter a value : /roots/pets.txt
```

#### 2. Command Line Flags
```sh
terraform apply -var "filename=/root/pets.txt" -var "content=We love pets"
```

#### 3. Environment Variables
```sh
export TF_VAR_filename="/root/pets.txt"
export TF_VAR_content="We love pets"
terraform apply
```

#### 4. Using Variable Definition Files
Write the filename as `terraform.tfvars` or `terraform.tfvars.json`.

**Example (`terraform.tfvars`):**
```hcl
filename = "/root/pets.txt"
content = "We love pets"
```

### Variable Definition Precedence
1. Environment Variables
2. `terraform.tfvars`
3. `*.auto.tfvars` (processed in alphabetical order)
4. `-var` or `-var-file` (command-line flags)

---

## 5. Resource Attributes
To access the value of one resource in another file, use the syntax:
```hcl
${provider_resourcetype.resource_name.attribute}
```

---

## 6. Output Variables

Output variables in Terraform allow you to extract useful information from your Terraform configurations. They help in displaying values after resource creation, making them accessible for use in other modules or external tools.

### Syntax
```hcl
output "output_name" {
  value       = <expression>  # The value to display or return
  description = "Description of the output"
  sensitive   = true/false    # (Optional) Hides sensitive output
}
```

### Displaying Output
To display the output of the config file, use:
```sh
terraform output


# Terraform Meta-Arguments: `depends_on` and `count`

Terraform supports special configuration keywords called **meta-arguments** that control behavior such as ordering, repetition, and lifecycle. They do not affect cloud APIs directly but influence how Terraform plans, creates, or destroys resources.

---

## What Are Meta-Arguments?

Meta-arguments are keywords that can be used inside:

- Resource blocks
- Module blocks
- Data sources (limited)

Examples of meta-arguments:

- `depends_on`
- `count`
- `for_each`
- `lifecycle`
- `provider`

This file explains **two important ones**:

1. `depends_on`
2. `count`

---

# 1. `depends_on` Meta-Argument

## Why It Exists

Terraform automatically infers dependencies whenever one resource references another.

Example — no `depends_on` required:

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id  # reference creates dependency
  cidr_block = "10.0.1.0/24"
}


```
**Syntax:**

depends_on = [
  resource.type.name,
  resource2.type.name
]


Example 1 — EC2 Instance Should Wait for Security Group

Without referencing the SG, Terraform can create resources in any order:

resource "aws_security_group" "web_sg" {
  name = "web-sg"
}

resource "aws_instance" "web" {
  ami           = "ami-1234567890abcdef0"
  instance_type = "t2.micro"
}


**To enforce ordering:**

resource "aws_instance" "web" {
  ami           = "ami-1234567890abcdef0"
  instance_type = "t2.micro"

  depends_on = [
    aws_security_group.web_sg
  ]
}

**Execution Order:**

Create Security Group

Create EC2 instance

**2. count Meta-Argument**

**Purpose**

count dynamically controls the number of resource or module instances created.

If count = 3, Terraform creates:

resource[0]

resource[1]

resource[2]

**Basic Example — Create 3 EC2 Instances**

```
resource "aws_instance" "web" {
  count         = 3
  ami           = "ami-1234567890abcdef0"
  instance_type = "t2.micro"
}
```

**3. foreach meta argument**


## What Is `for_each`?

`for_each` is a Terraform meta-argument used to create **multiple instances of a resource or module**, based on a **map, set, or list**. Each created resource has a **stable identity**, referenced by a key (not an index).

`for_each` is preferred over `count` when:
- Each resource must have a **unique name**
- Items may be added or removed later without re-creating all resources
- Order should not affect resource lifecycle

---

## Why Not Use `count` Always?

`count` creates resources based on index:

- `resource[0]`
- `resource[1]`
- `resource[2]`

If the list order changes, Terraform may delete and recreate resources.

`for_each`, however, uses **keys instead of indexes**, so identity is stable:

- `resource["server1"]`
- `resource["server2"]`

No recreation occurs if order changes.

---

# Basic Syntax

```hcl
resource "resource_type" "name" {
  for_each = {
    key1 = "value1"
    key2 = "value2"
  }

  # each.key  → key
  # each.value → value
}
```

**Example:**

```
variable "servers" {
  type = map(string)
  default = {
    app1 = "t2.micro"
    app2 = "t3.micro"
  }
}

resource "aws_instance" "web" {
  for_each      = var.servers
  ami           = "ami-1234567890abcdef0"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
```


