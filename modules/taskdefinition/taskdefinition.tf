locals {
  app_file = templatefile("${path.module}/app.yml", {region = var.aws_region})
  logrouter = file("${path.module}/logrouter.yml")
}
data aws_iam_role task {
  name = "${var.service_name}_task"
}

data aws_iam_role execution {
  name = "${var.service_name}_task"
}

resource "aws_ecs_task_definition" "this" {
 container_definitions = jsonencode(
    [
    yamldecode(local.app_file),
    yamldecode(local.logrouter)
 ]) 
 family = "app01"
 memory = "256"
 network_mode = "bridge"
 task_role_arn = data.aws_iam_role.task.arn
 execution_role_arn = data.aws_iam_role.execution.arn
 placement_constraints {
   expression = "attribute:disk-device-type in [ssd, nvme]"
   type = "memberOf"
 }
 skip_destroy = true
 volume {
    name = "volume-dados"
   docker_volume_configuration {
     autoprovision = true
     scope = "shared"
   }
 }
}