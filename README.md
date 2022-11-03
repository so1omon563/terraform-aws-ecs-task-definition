# ECS Task

Create an ECS task definition.

Note that this module does not currently support FSx Windows file system volumes.

Note on the `container_definitions` variable. This variable accepts json to define the [container definitions](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html).

The `container-definition` module can be used to generate this json, or it can be passed in on its own.

  > Proper escaping is required for JSON field values containing quotes (`"`) such as `environment` values.
  > If directly setting the JSON, they should be escaped as `\"` in the JSON, e.g. `"value": "I \"love\" escaped quotes"`.
  > If using a Terraform variable value, they should be escaped as `\\\"` in the variable, e.g. `value = "I \\\"love\\\" escaped quotes"` in the variable and `"value": "${var.myvariable}"` in the JSON.


## Quick Start

Examples may not be up to date.

### EC2 task
```hcl-terraform
module "task" {
  source      = "path/to/modules/task"
  name        = "web"
  launch_type = "EC2"

  memory = {
    hard_limit = 64
  }

  tags = {
    environment   = "ecs-ec2-task-example"
    t_environment = "DEV"
    t_AppID       = "SVC000000"
  }

  container_definitions = jsonencode([
    map(
      name, "nginx",
      image, "nginx:1.18-alpine",
      container, map(essential, true)
    )
  ])
}
```

### Fargate task
```hcl-terraform
module "task" {
  source      = "path/to/modules/task"
  name        = "web"
  launch_type = "FARGATE"

  fargate_settings = {
    cpu    = 512
    memory = 1024
  }

  tags = {
    environment   = "ecs-fargate-task-example"
    t_environment = "DEV"
    t_AppID       = "SVC000000"
  }

  container_definitions = jsonencode([
    map(
      name, "nginx",
      image, "nginx:1.18-alpine",
      container, map(essential, true)
    )
  ])
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.task_definition_ignore_changes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | A list of valid [container definitions](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html) provided as a single valid JSON document.<br>  Please note that you should only provide values that are part of the container definition document.<br>  For a detailed description of what parameters are available, see the [Task Definition Parameters](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html) section from the official [Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html). | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | (Optional) Number of cpu units used by the task. If the `requires_compatibilities` is `FARGATE` this field is required. See the **Task CPU and Memory** section of the [Developers Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html) for information on Fargate CPU and Memory limitations. | `number` | `null` | no |
| <a name="input_ephemeral_storage_size_in_gb"></a> [ephemeral\_storage\_size\_in\_gb](#input\_ephemeral\_storage\_size\_in\_gb) | The total amount, in GiB, of ephemeral storage to set for the task. This parameter is used to expand the total amount of ephemeral storage available, beyond the default amount, for tasks hosted on AWS Fargate. The minimum supported value is `21` GiB and the maximum supported value is `200` GiB. | `number` | `null` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. | `string` | `null` | no |
| <a name="input_family_name"></a> [family\_name](#input\_family\_name) | Name that will be added to `var.name` to name the task family. This will also be specifically used as the `task_name` unless `var.task_name_override` is provided. | `string` | `null` | no |
| <a name="input_ignore_changes"></a> [ignore\_changes](#input\_ignore\_changes) | If this is set to `true`, a task will be created that ignores all changes.<br>  This is useful if you wish to manage the task definitions outside of Terraform.<br>  Please note that changing this value after the initial creation will force a new task. | `bool` | `false` | no |
| <a name="input_inference_accelerator"></a> [inference\_accelerator](#input\_inference\_accelerator) | (Optional) Configuration block(s) with Inference Accelerators settings. Can be one or more.<br><br>  NOTE - If using this variable, all values must be provided, even if that value is `null`.<br><br>  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#inference_accelerator) carefully.<br>  Default values for the options are:<pre>default = [{<br>    # (Required) Elastic Inference accelerator device name. The deviceName must also be referenced in a container definition as a ResourceRequirement.<br>    device_name = null<br><br>    # (Required) Elastic Inference accelerator type to use.<br>    device_type = null<br>  }]</pre> | <pre>list(object({<br>    device_name = string<br>    device_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_ipc_mode"></a> [ipc\_mode](#input\_ipc\_mode) | (Optional) IPC resource namespace to be used for the containers in the task The valid values are `host`, `task`, and `none`. | `string` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | (Optional) Launch type on which to run your service. The valid values are `EC2`, `FARGATE`, and `EXTERNAL`. Defaults to `EC2`. | `string` | `"EC2"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | (Optional) Amount (in MiB) of memory used by the task. If the `requires_compatibilities` is `FARGATE` this field is required. See the **Task CPU and Memory** section of the [Developers Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html) for information on Fargate CPU and Memory limitations. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. Either this, or `task_name_override` must be provided. | `string` | `null` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The Docker networking mode to use for the containers in the task. Forced to 'awsvpc' for launch\_type = FARGATE. Acceptable values are `none`, `bridge`, `awsvpc`, and `host`. | `string` | `"bridge"` | no |
| <a name="input_pid_mode"></a> [pid\_mode](#input\_pid\_mode) | (Optional) Process namespace to use for the containers in the task. The valid values are `host` and `task`. | `string` | `null` | no |
| <a name="input_placement_constraints"></a> [placement\_constraints](#input\_placement\_constraints) | (Optional) Configuration block for rules that are taken into consideration during task placement. Maximum number of `placement_constraints` is `10`.<br><br>  NOTE - If using this variable, all values must be provided, even if that value is `null`.<br><br>  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#placement_constraints) carefully.<br>  Default values for the options are:<pre>default = [{<br>    # (Optional) Cluster Query Language expression to apply to the constraint.<br>    # See [Cluster Query Language in the Amazon EC2 Container Service Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) for more information.<br>    expression = null<br><br>    # (Required) Type of constraint. Use **memberOf** to restrict selection to a group of valid candidates. Note that **distinctInstance** is not supported in task definitions.<br>    type = null<br>  }]</pre> | <pre>list(object({<br>    expression = string<br>    type       = string<br>  }))</pre> | `[]` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | (Optional) Configuration block for the App Mesh proxy.<br><br>  NOTE - If using this variable, all values must be provided, even if that value is `null`. Can only accept one configuration block.<br><br>  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#proxy_configuration) carefully.<br>  Default values for the options are:<pre>default = [{<br>    # (Optional) (Required) Name of the container that will serve as the App Mesh proxy.<br>    container_name = null<br><br>    # (Required) Set of network configuration parameters to provide the Container Network Interface (CNI) plugin, specified a key-value mapping.<br>    properties = null<br><br>    # (Optional) Proxy type. The default value is **APPMESH**. The only supported value is **APPMESH**.<br>    type = "APPMESH"<br>  }]</pre> | <pre>list(object({<br>    container_name = string<br>    properties     = map(string)<br>    type           = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_task_name_override"></a> [task\_name\_override](#input\_task\_name\_override) | Used if there is a need to specify a task name that differs from the `family_name`. | `string` | `null` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. | `string` | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | (Optional) Configuration block for EFS or Docker volumes that containers in your task may use.<br><br>  NOTE - If using this variable, ALL values must be provided, even if that value is `null`.<br><br>  Please review all the [options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#volume) carefully.<br>  Information for the options are below:<pre>default = [{<br>    # (Optional) Path on the host container instance that is presented to the container.<br>    # If not set, ECS will create a nonpersistent data volume that starts empty and is deleted after the task has finished.<br>    host_path = null<br><br>    # (Required) Name of the volume. This name is referenced in the **sourceVolume** parameter of container definition in the **mountPoints** section.<br>    name = null<br><br>    # Specify a Docker volume for your task definition.<br>    # See [Specifying a Docker volume in your Task Definition Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-volumes.html#specify-volume-config) for more information.<br>    docker_volume_configuration = [{<br>      # (Optional) If this value is **true**, the Docker volume is created if it does not already exist. Note: This field is only used if the scope is **shared**.<br>      autoprovision = null<br><br>      # (Optional) Docker volume driver to use. The driver value must match the driver name provided by Docker because it is used for task placement.<br>      driver        = null<br><br>      # (Optional) Map of Docker driver specific options.<br>      driver_opts   = {}<br><br>      # (Optional) Map of custom metadata to add to your Docker volume.<br>      labels        = {}<br><br>      # (Optional) Scope for the Docker volume, which determines its lifecycle, either **task** or **shared**.<br>      # Docker volumes that are scoped to a **task** are automatically provisioned when the task starts and destroyed when the task stops.<br>      # Docker volumes that are scoped as **shared** persist after the task stops.<br>      scope         = null<br>    }]<br><br>    # Specify an EFS volume for your task definition.<br>    # See [Specifying an EFS volume in your Task Definition Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html#specify-efs-config) for more information.<br>    efs_volume_configuration = [{<br>      # (Required) ID of the EFS File System.<br>      file_system_id = null<br><br>      # (Optional) Directory within the Amazon EFS file system to mount as the root directory inside the host.<br>      # If this parameter is omitted, the root of the Amazon EFS volume will be used.<br>      # Specifying **/** will have the same effect as omitting this parameter. This argument is ignored when using **authorization_config**.<br>      root_directory = null<br><br>      # (Optional) Whether or not to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server.<br>      # Transit encryption must be enabled if Amazon EFS IAM authorization is used.<br>      # Valid values: **ENABLED**, **DISABLED**. If this parameter is omitted, the default value of **DISABLED** is used.<br>      transit_encryption = null<br><br>      # (Optional) Port to use for transit encryption.<br>      # If you do not specify a transit encryption port, it will use the port selection strategy that the Amazon EFS mount helper uses.<br>      transit_encryption_port = null<br>    }]<br><br>      # (Optional) Configuration block for authorization for the Amazon EFS file system.<br>      authorization_config = [{<br>        # (Optional) Access point ID to use. If an access point is specified, the root directory value will be relative to the directory set for the access point.<br>        # If specified, transit encryption must be enabled in the EFSVolumeConfiguration.<br>        access_point_id = null<br><br>        # (Optional) Whether or not to use the Amazon ECS task IAM role defined in a task definition when mounting the Amazon EFS file system.<br>        # If enabled, transit encryption must be enabled in the EFSVolumeConfiguration.<br>        # Valid values: **ENABLED**, **DISABLED**. If this parameter is omitted, the default value of **DISABLED** is used.<br>        iam = null<br>     }]<br>  }]</pre> | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ignore_changes"></a> [ignore\_changes](#output\_ignore\_changes) | Whether or not the task is set to ignore changes. |
| <a name="output_task_definition"></a> [task\_definition](#output\_task\_definition) | A collection of outputs for the created ECS Task Definition. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
