locals {
  tags        = var.tags
  launch_type = upper(var.launch_type)
  family_name = var.family_name != null ? format("%s-%s", var.name, var.family_name) : format("%s", var.name)
  task_name   = var.task_name_override != null ? var.task_name_override : local.family_name

  task_ignore       = var.ignore_changes == true ? { task_ignore = "ignore" } : {}
  task              = var.ignore_changes == false ? { task = "ignore" } : {}
  ephemeral_storage = var.ephemeral_storage_size_in_gb != null ? { ephemeral_storage = "ignore" } : {}
}
