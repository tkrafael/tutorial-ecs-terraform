resource aws_ecs_service this {
    for_each = toset(var.clusters)
    cluster = each.value
    name = var.service_name
    task_definition = "app01"
    desired_count = 1
    iam_role = "" # role que permite ao ecs chamar comandos no load balancer
    # scheduling_strategy = "DAEMON"
    ordered_placement_strategy {
        type  = "spread"
        field = "instanceId"
    }
    lifecycle {
        ignore_changes = [desired_count]
    }

    placement_constraints {
        type       = "memberOf"
        expression = "attribute:custom.disk_type in [ssd, nvme]"
    }
}

variable clusters {
    type = list(string)
}
variable service_name {
    type = string
}