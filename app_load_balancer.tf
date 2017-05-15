resource "aws_alb" "ecs" {
  internal        = false
  name            = "${var.project}-${var.environment}-alb"
  subnets         = ["${module.vpc.public_subnets}"]
  security_groups = ["${aws_security_group.elb.id}"]

  enable_deletion_protection = false

  # access_logs {
  #   bucket = "${aws_s3_bucket.elb_logs.id}"
  #   prefix = "alb-logs"
  # }

  tags {
    Name        = "${var.environment}-${var.application}-${var.name}-alb"
    Environment = "${var.environment}"
    Application = "${var.application}"
  }
}

resource "aws_alb_target_group" "ecs" {
  name     = "${var.project}-${var.environment}-alb-tg"
  port     = 8100
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"

  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    path = "/repository/image/metadata/v1/health"
    port = "8100"
    interval = 30
  }
}

resource "aws_alb_listener" "ecs" {
  load_balancer_arn = "${aws_alb.ecs.arn}"
  port              = "80"
  protocol          = "HTTP"

  # ssl_policy        = "ELBSecurityPolicy-2015-05"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    target_group_arn = "${aws_alb_target_group.ecs.arn}"
    type             = "forward"
  }
}
