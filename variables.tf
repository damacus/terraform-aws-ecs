variable "owner" {}
variable "project" {}
variable "application" {}
variable "cost_code" {}
variable "email" {}
variable "name" {}

variable "instance_type" {
  default = "t2.medium"
}

variable "target_container" {}
variable "desired_tasks" {}
variable "service-name" {}
variable "key_name" {}
variable "task_definition_arn" {}

variable "allowed_ips_80" {
  type = "list"
}

variable "allowed_ips_443" {
  type = "list"
}

variable "allowed_sg_80" {}
variable "allowed_sg_443" {}
variable "asg_desired_capacity" {}
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "asg_desired_capacity_up" {}
variable "asg_min_size_up" {}
variable "asg_max_size_up" {}
variable "asg_min_size_down" {}
variable "asg_max_size_down" {}
variable "asg_desired_capacity_down" {}
variable "listener_port" {}
variable "listener_protocol" {}
variable "health_check_port" {
  description = "Use traffic-port if you are using an ALB"
}

variable "schedule_recurrence_up" {
  default = "* 6 * * 1-5"
}

variable "schedule_recurrence_down" {
  default = "* 20 * * 1-5 "
}

variable "health_check_target" {
  default = "/"
}

variable "target_port" {
  default = "80"
}

variable "target_protocol" {
  default = "HTTP"
}

variable "internal_load_balancer" {
  default = true
}

variable "vpc_network" {}
variable "region" {}
