variable "owner" {}
variable "project" {}
variable "application" {}
variable "cost_code" {}
variable "email" {}

variable "name" {
  default = "ecs"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "target_container" {}
variable "desired_tasks" {}
variable "service-name" {}
variable "key_name" {}
variable "task_definition_arn" {}

variable "allowed_ips" {
  type = "list"
}

variable "asg_desired_capacity" {
  default = "3"
}

variable "asg_max_size" {
  default = "5"
}

variable "asg_min_size" {
  default = "3"
}

variable "asg_desired_capacity_up" {
  default = "3"
}

variable "asg_min_size_up" {
  default = "3"
}

variable "asg_max_size_up" {
  default = "5"
}

variable "asg_min_size_down" {
  default = "0"
}

variable "asg_max_size_down" {
  default = "0"
}

variable "asg_desired_capacity_down" {
  default = "0"
}

variable "listener_port" {
  default = "80"
}

variable "listener_protocol" {
  default = "HTTP"
}

variable "health_check_port" {
  default = "80"
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
  default = false
}

variable "vpc_network" {}
variable "availability_zone" {}
