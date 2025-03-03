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

