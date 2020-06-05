module "ecs-autoscaling-group" {
  source           = "damacus/ecs/aws"
  name             = "ecs-asg-${terraform.workspace}"
  vpc_id           = module.vpc.vpc_id
  subnets          = module.vpc.private_subnets
  security_groups  = [aws_security_group.ecs_cluster.id]
  ami              = data.aws_ami.ecs-optimized.id
  key_name         = var.key_name
  instance_profile = aws_iam_instance_profile.ecs.id
  map_public_ip    = false

  # Starting capacity
  asg_desired_capacity = var.asg_desired_capacity
  asg_max_size         = var.asg_max_size
  asg_min_size         = var.asg_min_size

  # Day schedule
  asg_desired_capacity_up = var.asg_desired_capacity_up
  asg_min_size_up         = var.asg_min_size_up
  asg_max_size_up         = var.asg_max_size_up

  # Night Schedule
  asg_min_size_down         = var.asg_min_size_down
  asg_max_size_down         = var.asg_max_size_down
  asg_desired_capacity_down = var.asg_desired_capacity_down

  schedule_recurrence_up   = var.schedule_recurrence_up
  schedule_recurrence_down = var.schedule_recurrence_down

  load_balancers = ""

  user_data_script = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.ecs.name} >> /etc/ecs/ecs.config"
  zones            = [data.aws_availability_zones.available.names]

  # Tags
  tags = var.tags
}

module "vpc" {
  source  = "damacus/vpc/aws"
  version = "3.0.4"
  tags    = var.tags
}
