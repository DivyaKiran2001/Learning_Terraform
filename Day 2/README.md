
# Terraform State

Terraform state is a JSON-formatted file (`terraform.tfstate`) that stores information about:

- The current infrastructure deployed using Terraform
- The metadata required for Terraform to manage and update resources
- Resource dependencies and relationships

Terraform state file keeps track of real-world resources mapped to Terraform configurations. This prevents Terraform from recreating existing infrastructure.

**Terraform state file is stored in the same directory with the name `terraform.tfstate`.**

## Terraform Commands

### 1. Terraform Validate

The `terraform validate` command is used to check the syntax and structure of your Terraform configuration files before applying any changes. It ensures that your configuration is syntactically correct and follows Terraform’s rules.

```sh
terraform validate
```

### 2. Terraform fmt (Format)

The `terraform fmt` command automatically formats Terraform configuration files to follow best practices and maintain consistent code style.

```sh
terraform fmt
```

### 3. Terraform show

The `terraform show` command is used to display details about the Terraform state or a Terraform plan in a human-readable format. It helps understand the current infrastructure state or see planned changes before applying them.

```sh
terraform show
```

### 4. Terraform providers

To list all the providers in the configuration directory:

```sh
terraform providers
```

### 5. Terraform output

Displays the values of outputs in the configuration file:

```sh
terraform output
```

### 6. Terraform graph

The `terraform graph` command generates a visual representation of your Terraform dependency graph.

```sh
terraform graph
```

## LifeCycle Rules

### 1. `create_before_destroy`

The `create_before_destroy` behavior is part of Terraform's resource lifecycle rules, allowing Terraform to create a new resource before destroying the old one.

### 2. `prevent_destroy`

The `prevent_destroy` lifecycle rule prevents Terraform from accidentally destroying critical resources.

### 3. `ignore_changes`

The `ignore_changes` lifecycle rule prevents Terraform from modifying certain resource attributes even if they change outside Terraform (e.g., manual updates in the cloud provider).

## Data Sources

A data source in Terraform is used to fetch or reference existing infrastructure rather than creating new resources. This allows Terraform to retrieve information about external resources and use it in your configuration.

**Syntax:**

```hcl
data "<PROVIDER>_<RESOURCE_TYPE>" "<NAME>" {
  # Configuration options
}
```

## Meta Arguments

### 1. `count`

Creates multiple instances of a resource.

- `length(list_name)` - Returns the length of the list.

### 2. `for_each`

Iterates over maps or sets to create resources dynamically.
