resource "aws_alb" "ecs" {
  internal        = "${var.internal_load_balancer}"
  name            = "${var.project}-${terraform.env}-alb"
  subnets         = ["${module.vpc.public_subnets}"]
  security_groups = ["${aws_security_group.load_balancer.id}"]

  enable_deletion_protection = false

  access_logs {
    bucket = "${aws_s3_bucket.lb_logs.id}"
  }

  tags {
    Name        = "${terraform.env}-${var.application}-${var.name}-alb"
    Environment = "${terraform.env}"
    Application = "${var.application}"
  }
}

resource "aws_alb_target_group" "ecs" {
  name     = "${var.project}-${terraform.env}-alb-tg"
  port     = "${var.target_port}"
  protocol = "${var.target_protocol}"
  vpc_id   = "${module.vpc.vpc_id}"

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    path                = "${var.health_check_target}"
    port                = "${var.health_check_port}"
    interval            = 30
  }
}

resource "aws_alb_listener" "ecs" {
  load_balancer_arn = "${aws_alb.ecs.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"

  # ssl_policy        = "ELBSecurityPolicy-2015-05"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    target_group_arn = "${aws_alb_target_group.ecs.arn}"
    type             = "forward"
  }
}
