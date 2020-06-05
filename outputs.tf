output "load_balancer_cname" {
  value = aws_alb.ecs.dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
