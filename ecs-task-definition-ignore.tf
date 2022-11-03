resource "aws_ecs_task_definition" "task_definition_ignore_changes" {
  for_each              = local.task_ignore
  container_definitions = var.container_definitions
  family                = local.family_name
  cpu                   = var.cpu
  execution_role_arn    = var.execution_role_arn

  dynamic "inference_accelerator" {
    for_each = var.inference_accelerator
    content {
      device_name = lookup(inference_accelerator.value, "device_name", null)
      device_type = lookup(inference_accelerator.value, "device_type", null)
    }
  }

  ipc_mode     = var.ipc_mode
  memory       = var.memory
  network_mode = local.launch_type == "FARGATE" ? "awsvpc" : var.network_mode
  pid_mode     = var.pid_mode

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      type       = lookup(placement_constraints.value, "type", null)
      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      type           = lookup(proxy_configuration.value, "type", null)
      container_name = lookup(proxy_configuration.value, "container_name", null)
      properties     = lookup(proxy_configuration.value, "properties", null)
    }
  }

  dynamic "ephemeral_storage" {
    for_each = local.ephemeral_storage
    content {
      size_in_gib = var.ephemeral_storage_size_in_gb
    }
  }

  requires_compatibilities = local.launch_type != "EXTERNAL" ? [local.launch_type] : null
  tags                     = local.tags

  task_role_arn = var.task_role_arn

  dynamic "volume" {
    for_each = var.volumes
    content {
      name = volume.value.name

      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)
          dynamic "authorization_config" {
            for_each = lookup(efs_volume_configuration.value, "authorization_config", [])
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = all
  }
}
