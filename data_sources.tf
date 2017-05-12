data "aws_ami" "ecs-optimized" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*.g-amazon-ecs-optimized"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_elb_service_account" "main" {}
