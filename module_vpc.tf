module "vpc" {
  source      = "git@github.com:damacus/terraform-module-vpc.git?ref=v1.0.6"
  cost_code   = "${var.cost_code}"
  environment = "${terraform.env}"
  owner       = "${var.owner}"
  email       = "${var.email}"
  nat_count   = 3
}
