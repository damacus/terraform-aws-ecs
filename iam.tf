data "aws_iam_policy_document" "ecs" {
  statement {
    actions = [
      "autoscaling:Describe*",
      "autoscaling:UpdateAutoScalingGroup",
      "cloudwatch:GetMetricStatistics",
      "iam:ListInstanceProfiles",
      "iam:ListRoles",
      "iam:PassRole",
      "ecs:*",
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "xray:*",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

# Policy for the role which allows it to use STS to get credentials to access EC2.
resource "aws_iam_role" "ecs" {
  name               = "ecs_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

# Rules to apply to the role
resource "aws_iam_role_policy" "ecs" {
  name   = "ecs_role_policy"
  role   = "${aws_iam_role.ecs.id}"
  policy = "${data.aws_iam_policy_document.ecs.json}"
}

# Roles to apply to an instance
resource "aws_iam_instance_profile" "ecs" {
  name = "ecs_profile"
  role = "${aws_iam_role.ecs.name}"
}
