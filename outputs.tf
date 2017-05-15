output "load_balancer_cname" {
  value = "${aws_alb.ecs.dns_name}"
}
