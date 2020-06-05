resource "aws_alb" "ecs" {
  internal                   = var.internal_load_balancer
  name                       = "${var.project}-${terraform.workspace}-alb"
  subnets                    = module.vpc.public_subnets
  security_groups            = aws_security_group.load_balancer.id
  enable_deletion_protection = false

  access_logs {
    bucket = aws_s3_bucket.lb_logs.id
  }

  tags = merge(
    var.tags,
    { Name = "${terraform.workspace}-${var.application}-${var.name}-alb" }
  )
}

resource "aws_alb_target_group" "ecs" {
  name_prefix = "tg-"
  port        = var.target_port
  protocol    = var.target_protocol
  vpc_id      = module.vpc.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    path                = var.health_check_target
    port                = var.health_check_port
    interval            = 30
  }

  tags = merge(
    var.tags,
    { "Name" = "${terraform.workspace}-${var.application}-${var.name}-tg" }
  )
}

resource "aws_alb_listener" "ecs" {
  load_balancer_arn = aws_alb.ecs.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    target_group_arn = aws_alb_target_group.ecs.arn
    type             = "forward"
  }
}
