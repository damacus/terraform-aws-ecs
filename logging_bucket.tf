resource "aws_s3_bucket" "elb_logs" {
  bucket = "logging-elb-logs-${var.environment}-${var.name}"
  acl    = "bucket-owner-full-control"
  region = "${var.region}"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "log"
    prefix  = "log/"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::logging-elb-logs-${var.environment}/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY

  tags {
    Name        = "${var.environment}-${var.application}-${var.name}"
    Environment = "${var.environment}"
    Application = "${var.application}"
    cost_code   = "${var.cost_code}"
  }
}
