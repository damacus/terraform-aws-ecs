resource "aws_ecs_cluster" "metadata" {
  name = "${var.service-name}"
}

resource "aws_ecs_service" "metadata" {
  name            = "${var.service-name}"
  cluster         = "${aws_ecs_cluster.metadata.id}"
  task_definition = "${var.task_definition_arn}"
  desired_count   = "${var.desired_count}"
  iam_role        = "${aws_iam_role.ecs.arn}"
  depends_on      = ["aws_iam_role_policy.ecs"]

  placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    elb_name       = "${aws_elb.ecs.name}"
    container_name = "${var.target_container}"
    container_port = "${var.target_port}"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-1a, eu-west-1b, eu-west-1c]"
  }
}
