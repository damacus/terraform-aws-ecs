module "vpc" {
  source            = "git@github.com:damacus/terraform-module-vpc.git?ref=v1.1.2"
  cost_code         = "${var.cost_code}"
  owner             = "${var.owner}"
  email             = "${var.email}"
  vpc_network       = "${var.vpc_network}"
  availability_zone = "${var.region}"
}
