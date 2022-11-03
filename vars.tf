variable "container_definitions" {
  type        = string
  description = <<EOT
  A list of valid [container definitions](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html) provided as a single valid JSON document.
  Please note that you should only provide values that are part of the container definition document.
  For a detailed description of what parameters are available, see the [Task Definition Parameters](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html) section from the official [Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html).
EOT
}

variable "cpu" {
  type        = number
  description = "(Optional) Number of cpu units used by the task. If the `requires_compatibilities` is `FARGATE` this field is required. See the **Task CPU and Memory** section of the [Developers Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html) for information on Fargate CPU and Memory limitations."
  default     = null
}

variable "ephemeral_storage_size_in_gb" {
  type        = number
  description = "The total amount, in GiB, of ephemeral storage to set for the task. This parameter is used to expand the total amount of ephemeral storage available, beyond the default amount, for tasks hosted on AWS Fargate. The minimum supported value is `21` GiB and the maximum supported value is `200` GiB."
  default     = null
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  default     = null
}

variable "family_name" {
  type        = string
  description = "Name that will be added to `var.name` to name the task family. This will also be specifically used as the `task_name` unless `var.task_name_override` is provided."
  default     = null
}

variable "ignore_changes" {
  type        = bool
  description = <<EOT
  If this is set to `true`, a task will be created that ignores all changes.
  This is useful if you wish to manage the task definitions outside of Terraform.
  Please note that changing this value after the initial creation will force a new task.
  EOT
  default     = false
}

variable "inference_accelerator" {
  type = list(object({
    device_name = string
    device_type = string
  }))
  description = <<EOT
  (Optional) Configuration block(s) with Inference Accelerators settings. Can be one or more.

  NOTE - If using this variable, all values must be provided, even if that value is `null`.

  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#inference_accelerator) carefully.
  Default values for the options are:
```
  default = [{
    # (Required) Elastic Inference accelerator device name. The deviceName must also be referenced in a container definition as a ResourceRequirement.
    device_name = null

    # (Required) Elastic Inference accelerator type to use.
    device_type = null
  }]
```
  EOT
  default     = []
}

variable "ipc_mode" {
  type        = string
  description = "(Optional) IPC resource namespace to be used for the containers in the task The valid values are `host`, `task`, and `none`."
  default     = null
  validation {
    condition = var.ipc_mode == null ? true : contains([
      "host",
      "task",
      "none"
    ], var.ipc_mode)
    error_message = "Valid options for `var.ipc_mode` are limited to `host`, `task`, `none` and `null`."
  }
}

variable "launch_type" {
  type        = string
  description = "(Optional) Launch type on which to run your service. The valid values are `EC2`, `FARGATE`, and `EXTERNAL`. Defaults to `EC2`."
  default     = "EC2"
  validation {
    condition = contains([
      "EC2",
      "FARGATE",
      "EXTERNAL"
    ], var.launch_type)
    error_message = "Valid options for `var.launch_type` are limited to `EC2`, `FARGATE`, or `EXTERNAL`."
  }
}

variable "memory" {
  type        = number
  description = "(Optional) Amount (in MiB) of memory used by the task. If the `requires_compatibilities` is `FARGATE` this field is required. See the **Task CPU and Memory** section of the [Developers Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html) for information on Fargate CPU and Memory limitations."
  default     = null
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix. Either this, or `task_name_override` must be provided."
  default     = null
}

variable "network_mode" {
  type        = string
  description = "The Docker networking mode to use for the containers in the task. Forced to 'awsvpc' for launch_type = FARGATE. Acceptable values are `none`, `bridge`, `awsvpc`, and `host`."
  default     = "bridge"
  validation {
    condition = contains([
      "none",
      "bridge",
      "awsvpc",
      "host"
    ], var.network_mode)
    error_message = "Valid options for `var.network_mode` are limited to `none`, `bridge`, `awsvpc`, or `host`."
  }
}

variable "pid_mode" {
  type        = string
  description = "(Optional) Process namespace to use for the containers in the task. The valid values are `host` and `task`."
  default     = null
  validation {
    condition = var.pid_mode == null ? true : contains([
      "host",
      "task"
    ], var.pid_mode)
    error_message = "Valid options for `var.pid_mode` are limited to `host`, `task`, and `null`."
  }
}

variable "placement_constraints" {
  type = list(object({
    expression = string
    type       = string
  }))
  description = <<EOT
  (Optional) Configuration block for rules that are taken into consideration during task placement. Maximum number of `placement_constraints` is `10`.

  NOTE - If using this variable, all values must be provided, even if that value is `null`.

  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#placement_constraints) carefully.
  Default values for the options are:
```
  default = [{
    # (Optional) Cluster Query Language expression to apply to the constraint.
    # See [Cluster Query Language in the Amazon EC2 Container Service Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) for more information.
    expression = null

    # (Required) Type of constraint. Use **memberOf** to restrict selection to a group of valid candidates. Note that **distinctInstance** is not supported in task definitions.
    type = null
  }]
```
  EOT
  default     = []
}

variable "proxy_configuration" {
  type = list(object({
    container_name = string
    properties     = map(string)
    type           = string
  }))
  description = <<EOT
  (Optional) Configuration block for the App Mesh proxy.

  NOTE - If using this variable, all values must be provided, even if that value is `null`. Can only accept one configuration block.

  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#proxy_configuration) carefully.
  Default values for the options are:
```
  default = [{
    # (Optional) (Required) Name of the container that will serve as the App Mesh proxy.
    container_name = null

    # (Required) Set of network configuration parameters to provide the Container Network Interface (CNI) plugin, specified a key-value mapping.
    properties = null

    # (Optional) Proxy type. The default value is **APPMESH**. The only supported value is **APPMESH**.
    type = "APPMESH"
  }]
```
  EOT
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "task_name_override" {
  type        = string
  description = "Used if there is a need to specify a task name that differs from the `family_name`."
  default     = null
}

variable "task_role_arn" {
  type        = string
  description = "ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  default     = null
}

variable "volumes" {
  type = list(object({
    host_path = string
    name      = string
    docker_volume_configuration = list(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
    efs_volume_configuration = list(object({
      file_system_id          = string
      root_directory          = string
      transit_encryption      = string
      transit_encryption_port = string
      authorization_config = list(object({
        access_point_id = string
        iam             = string
      }))
    }))
  }))

  description = <<EOT
  (Optional) Configuration block for EFS or Docker volumes that containers in your task may use.

  NOTE - If using this variable, ALL values must be provided, even if that value is `null`.

  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#volume) carefully.
  Information for the options are below:
```
  default = [{
    # (Optional) Path on the host container instance that is presented to the container.
    # If not set, ECS will create a nonpersistent data volume that starts empty and is deleted after the task has finished.
    host_path = null

    # (Required) Name of the volume. This name is referenced in the **sourceVolume** parameter of container definition in the **mountPoints** section.
    name = null

    # Specify a Docker volume for your task definition.
    # See [Specifying a Docker volume in your Task Definition Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-volumes.html#specify-volume-config) for more information.
    docker_volume_configuration = [{
      # (Optional) If this value is **true**, the Docker volume is created if it does not already exist. Note: This field is only used if the scope is **shared**.
      autoprovision = null

      # (Optional) Docker volume driver to use. The driver value must match the driver name provided by Docker because it is used for task placement.
      driver        = null

      # (Optional) Map of Docker driver specific options.
      driver_opts   = {}

      # (Optional) Map of custom metadata to add to your Docker volume.
      labels        = {}

      # (Optional) Scope for the Docker volume, which determines its lifecycle, either **task** or **shared**.
      # Docker volumes that are scoped to a **task** are automatically provisioned when the task starts and destroyed when the task stops.
      # Docker volumes that are scoped as **shared** persist after the task stops.
      scope         = null
    }]

    # Specify an EFS volume for your task definition.
    # See [Specifying an EFS volume in your Task Definition Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html#specify-efs-config) for more information.
    efs_volume_configuration = [{
      # (Required) ID of the EFS File System.
      file_system_id = null

      # (Optional) Directory within the Amazon EFS file system to mount as the root directory inside the host.
      # If this parameter is omitted, the root of the Amazon EFS volume will be used.
      # Specifying **/** will have the same effect as omitting this parameter. This argument is ignored when using **authorization_config**.
      root_directory = null

      # (Optional) Whether or not to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server.
      # Transit encryption must be enabled if Amazon EFS IAM authorization is used.
      # Valid values: **ENABLED**, **DISABLED**. If this parameter is omitted, the default value of **DISABLED** is used.
      transit_encryption = null

      # (Optional) Port to use for transit encryption.
      # If you do not specify a transit encryption port, it will use the port selection strategy that the Amazon EFS mount helper uses.
      transit_encryption_port = null
    }]

      # (Optional) Configuration block for authorization for the Amazon EFS file system.
      authorization_config = [{
        # (Optional) Access point ID to use. If an access point is specified, the root directory value will be relative to the directory set for the access point.
        # If specified, transit encryption must be enabled in the EFSVolumeConfiguration.
        access_point_id = null

        # (Optional) Whether or not to use the Amazon ECS task IAM role defined in a task definition when mounting the Amazon EFS file system.
        # If enabled, transit encryption must be enabled in the EFSVolumeConfiguration.
        # Valid values: **ENABLED**, **DISABLED**. If this parameter is omitted, the default value of **DISABLED** is used.
        iam = null
     }]
  }]
```
  EOT
  default     = []
}
