variable "cost_code" {}
variable "owner" {}
variable "environment" {}
variable "project" {}
variable "application" {}
variable "cost_code" {}
variable "email" {}
variable "region" {}

variable "name" {
  default = "ecs"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "target_container" {}
variable "target_port" {}
variable "desired_count" {}
variable "health_check_target" {}
variable "service-name" {}
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
