# Basic Usage

Basic quickstart for creating a task definition with multiple container definitions.

This example uses the `ecs-container-definition` module to create the container definitions.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Examples

```hcl
provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

# Using the `ecs-container-definition` module to create 2 container definitions
module "container" {
  source  = "so1omon563/ecs-container-definition/aws"
  version = "2.0.0" # Replace with appropriate version

  name  = "nginx"
  image = "nginx:1.18-alpine"

  essential = true
  memory    = 64

  port_mappings = [8080]

  environment_variables = {
    NGINX_PORT = 8080
  }
}

module "container2" {
  source  = "so1omon563/ecs-container-definition/aws"
  version = "2.0.0" # Replace with appropriate version

  name  = "nginx2"
  image = "nginx:1.18-alpine"

  essential = true
  memory    = 64

  port_mappings = [8888]

  environment_variables = {
    NGINX_PORT = 8888
  }
}

# Creating the task using the 2 container definitions
module "task" {
  source = "../../"
  # Replace with appropriate version

  name = "example-task"
  # Put multiple containers in a task
  container_definitions = "[  ${module.container.json}, ${module.container2.json} ]"
  tags = {
    example = "true"
  }
}

output "task_definition" {
  value = module.task.task_definition
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container"></a> [container](#module\_container) | so1omon563/ecs-container-definition/aws | 2.0.0 |
| <a name="module_container2"></a> [container2](#module\_container2) | so1omon563/ecs-container-definition/aws | 2.0.0 |
| <a name="module_task"></a> [task](#module\_task) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_definition"></a> [task\_definition](#output\_task\_definition) | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
