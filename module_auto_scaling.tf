module "ecs-autoscaling-group" {
  source           = "git@github.com:damacus/terraform-module-asg.git"
  name             = "ecs-asg"
  vpc_id           = "${module.vpc.vpc_id}"
  subnets          = "${module.vpc.private_subnets}"
  security_groups  = ["${aws_security_group.ecs_cluster.id}"]
  ami              = "${data.aws_ami.ecs-optimized.id}"
  key_name         = "${var.key_name}"
  instance_profile = "${aws_iam_instance_profile.ecs.id}"
  map_public_ip    = false

  asg_max_size              = "5"
  asg_min_size              = "3"
  asg_min_size_up           = "3"
  asg_min_size_down         = "0"
  asg_max_size_up           = "5"
  asg_max_size_down         = "0"
  asg_desired_capacity_up   = "3"
  asg_desired_capacity_down = "0"
  asg_desired_capacity      = "3"
  load_balancers            = ""

  user_data_script = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.ecs.name} >> /etc/ecs/ecs.config"
  zones            = ["${data.aws_availability_zones.available.names}"]

  # Tags
  cost_code   = "${var.cost_code}"
  application = "${var.service-name}"
  description = "ecs-cluster for ${var.service-name}"
  owner       = "${var.owner}"
  environment = "${var.environment}"
}
