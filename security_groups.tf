# Passed into AutoScaling Groop
resource "aws_security_group" "ecs_cluster" {
  name        = "${var.environment}_${var.name}_sg"
  description = "ECS Security group"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name        = "${var.environment}-${var.application}-${var.name}"
    Environment = "${var.environment}"
    Application = "${var.application}"
  }
}

resource "aws_security_group_rule" "instance_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs_cluster.id}"
}

resource "aws_security_group_rule" "instance_in_elb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.elb.id}"
  security_group_id        = "${aws_security_group.ecs_cluster.id}"
}

resource "aws_security_group_rule" "instance_out_elb" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.elb.id}"
  security_group_id        = "${aws_security_group.ecs_cluster.id}"
}
