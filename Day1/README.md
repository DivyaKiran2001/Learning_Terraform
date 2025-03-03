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
This Markdown file is suitable for GitHub documentation and provides a structured introduction to Terraform basics.
