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

# Passing in values directly to the `container_definitions` variable to create a task
module "task-direct-definition" {
  source = "../../"
  # Replace with appropriate version

  name = "example-task-direct-definition"
  # Pass in a definition directly
  container_definitions = jsonencode([
    {
      name   = "nginx",
      image  = "nginx:1.18-alpine",
      memory = 64,
      container = {
        essential = true
      }
    }
  ])
  tags = {
    example = "true"
  }
}

output "task_definition_direct_definition" {
  value = module.task-direct-definition.task_definition
}



