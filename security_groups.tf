# AutoScaling Group
# These are passed into the ASG Module
resource "aws_security_group" "ecs_cluster" {
  name        = "${terraform.env}_${var.name}_sg"
  description = "ECS Security group"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name        = "${terraform.env}-${var.application}-${var.name}"
    Environment = "${terraform.env}"
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

resource "aws_security_group_rule" "instance_in_load_balancer" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.load_balancer.id}"
  security_group_id        = "${aws_security_group.ecs_cluster.id}"
}

resource "aws_security_group_rule" "instance_out_load_balancer" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.load_balancer.id}"
  security_group_id        = "${aws_security_group.ecs_cluster.id}"
}

# Load Balancer
resource "aws_security_group" "load_balancer" {
  name        = "load_balancer-${terraform.env}_${var.name}_sg"
  description = "Load Balancer Security group"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name        = "${terraform.env}-${var.application}-${var.name}"
    Environment = "${terraform.env}"
    Application = "${var.application}"
  }
}

resource "aws_security_group_rule" "in_80" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["${var.allowed_ips_80}"]
  security_group_id = "${aws_security_group.load_balancer.id}"
}

resource "aws_security_group_rule" "in_443" {
  type              = "ingress"
  protocol          = "TCP"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["${var.allowed_ips_443}"]
  security_group_id = "${aws_security_group.load_balancer.id}"
}

resource "aws_security_group_rule" "allowed_sg_80" {
  type                     = "ingress"
  protocol                 = "TCP"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = "${var.allowed_sg_80}"
  security_group_id        = "${aws_security_group.load_balancer.id}"
}

resource "aws_security_group_rule" "allowed_sg_443" {
  type                     = "ingress"
  protocol                 = "TCP"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = "${var.allowed_sg_443}"
  security_group_id        = "${aws_security_group.load_balancer.id}"
}

resource "aws_security_group_rule" "self_ingress" {
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
  security_group_id = "${aws_security_group.load_balancer.id}"
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.load_balancer.id}"
}
