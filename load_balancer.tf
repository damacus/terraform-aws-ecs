resource "aws_elb" "ecs" {
  name            = "${var.project}-${var.environment}-elb"
  subnets         = ["${module.vpc.public_subnets}"]
  security_groups = ["${aws_security_group.elb.id}"]

  access_logs {
    bucket   = "${aws_s3_bucket.elb_logs.id}"
    interval = 5
  }

  listener {
    instance_port     = "${var.target_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name        = "${var.environment}-${var.application}-${var.name}"
    Environment = "${var.environment}"
    Application = "${var.application}"
  }
}

resource "aws_security_group" "elb" {
  name        = "ELB-${var.environment}_${var.name}_sg"
  description = "ELB Security group"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name        = "${var.environment}-${var.application}-${var.name}"
    Environment = "${var.environment}"
    Application = "${var.application}"
  }
}

resource "aws_security_group_rule" "pa_in_80" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["${var.allowed_ips}"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "self_ingress" {
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}
