variable "name" {}

variable "tags" {}

provider "aws" {
  default_tags {
    tags = var.tags
  }
}

# Using the `ecs-container-definition` module to create 2 container definitions
module "container" {
  source  = "so1omon563/ecs-container-definition/aws"
  version = "2.0.0"

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
  version = "2.0.0"

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
  source = "../../../"
  # Replace with appropriate version

  name = var.name
  # Put multiple containers in a task
  container_definitions = "[  ${module.container.json}, ${module.container2.json} ]"
  tags = {
    example = "true"
  }
}

output "task_definition" {
  value = module.task.task_definition
}
