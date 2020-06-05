
variable "name" {
  type        = string
  description = "A descriptive name for your service."
}

variable "instance_type" {
  type = string

  description = "(Optional) EC2 Instance type to run the cluster on."
  default     = "t2.medium"
}

variable "target_container" {
  type        = string
  description = "Default container name to point to."
}

variable "desired_task_count" {
  type        = number
  description = "(Optional) Number of desired running containers"
  default     = 3
}

variable "service-name" {
  type        = string
  description = "(Optional) Name of the ECS Service."
  default     = "Default Service"
}

variable "ssh_key_name" {
  type        = string
  description = "(Optional) Name of the SSH key to allow access to the EC2 boxes"
}

variable "task_definition_arn" {
  type        = string
  description = "(Required) The family and revision (family:revision) or full ARN of the task definition that you want to run in your service."
}

variable "allowed_ips_80" {
  type        = list(string)
  description = "(Optional) A list of IPs allowed to communicate with theALB on port 80."
  default     = [""]
}

variable "allowed_ips_443" {
  type        = list(string)
  description = "(Optional) A list of IPs allowed to communicate with the LB on port 443."
  default     = [""]
}

variable "allowed_sg_80" {
  type        = string
  description = "The AWS securiy Group name allowed to access the LB on port 80."
  default     = ""
}

variable "allowed_sg_443" {
  type        = string
  description = "The AWS securiy Group name allowed to access the LB on port 443."
  default     = ""
}

variable "asg_desired_capacity" {
  type        = string
  description = "(Optional) The desired capacity of the auto scalling group"
}


## AutoScalling
variable "asg_min_size" {
  type        = number
  description = "(Optional) Minimum number of instances during standard operation"
  default     = 3
}

variable "asg_max_size" {
  type        = number
  description = "(Optional) Maximum number of instances during standard operation"
  default     = 3
}

variable "asg_desired_capacity" {
  type        = number
  description = "(Optional) Desired number of instances during standard operation"
  default     = 3
}

variable "asg_min_size_up" {
  type        = number
  description = "(Optional) Minimum number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)"
  default     = 3
}

variable "asg_max_size_up" {
  type        = number
  description = "(Optional) Maximum number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)"
  default     = 3
}

variable "asg_desired_capacity_up" {
  type        = number
  description = "(Optional) Desired number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)"
  default     = 3
}

variable "asg_min_size_down" {
  type        = number
  description = "(Optional) Minimum number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)"
  default     = 0
}

variable "asg_max_size_down" {
  type        = number
  description = "(Optional) Maximum number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)"
  default     = 0
}

variable "asg_desired_capacity_down" {
  type        = number
  description = "(Optional) Desired number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)"
  default     = 0
}

variable "listener_port" {}

variable "listener_protocol" {}

variable "health_check_port" {
  description = "(Optional) Use traffic-port if you are using an ALB"
}

variable "schedule_recurrence_up" {
  description = "Schedule time in Unix cron syntax format for the UP action"
  default     = "* 6 * * 1-5"
  type        = string
}

variable "schedule_recurrence_down" {
  description = "Schedule time in Unix cron syntax format for the DOWN action"
  default     = "* 20 * * 1-5"
  type        = string
}

variable "health_check_target" {
  default     = "/"
  type        = string
  description = "(Optional) Path to for HTTP healthcheck."
}

variable "target_port" {
  default     = "80"
  type        = number
  description = "(Optional) Port number to communicate with the defautl container on."
}

variable "target_protocol" {
  type        = string
  description = "(Optional) Protocol to use, to communicate with the container"
  default     = "HTTP"
}

variable "internal_load_balancer" {
  default     = true
  description = "(Optional) If true, the LB will be internal."
  type        = bool
}

variable "vpc_network" {}

variable "region" {}

variable "force_detach_policies" {
  default     = "false"
  type        = string
  description = "(Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to false."
}
