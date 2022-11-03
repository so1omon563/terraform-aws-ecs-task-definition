output "ignore_changes" {
  value = var.ignore_changes
  description = "Whether or not the task is set to ignore changes."
}


output "task_definition" {
  description = "A collection of outputs for the created ECS Task Definition."
  value = merge(
    {
      for key, value in aws_ecs_task_definition.task_definition : key => value
    },
    {
      for key, value in aws_ecs_task_definition.task_definition_ignore_changes : key => value
    }
  )
}
