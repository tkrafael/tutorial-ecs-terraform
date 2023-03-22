data aws_iam_policy_document assumerole_policy {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    sid = "allowecs"
    principals {
      type = "Service"
      identifiers = [
      "ecs-tasks.amazonaws.com",
      "ecs.amazonaws.com"
      ]
    }
  }
}

resource aws_iam_role task{
    name = "${var.service_name}_task"
    assume_role_policy = data.aws_iam_policy_document.assumerole_policy.json
}

resource aws_iam_role execution {
    name = "${var.service_name}_execution"
    assume_role_policy = data.aws_iam_policy_document.assumerole_policy.json
}
