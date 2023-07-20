resource "aws_iam_role" "scheduler" {
    name = "cloud_custodian_scheduler_${var.env}"
    assume_role_policy = data.aws_iam_policy_document.scheduler_trust.json
}

resource "aws_iam_role_policy" "scheduler" {
    name = "cloud_custodian_scheduler${var.env}"
    role = aws_iam_role.scheduler.id
    policy = data.aws_iam_policy_document.scheduler_policy.json
}

data "aws_iam_policy_document" "scheduler_trust" {
    statement {
      actions = ["sts:AssumeRole"]

      principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
}

data "aws_iam_policy_document" "scheduler_policy" {
    statement {
      actions = [
        "logs:CreateLogStream",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ]

      resources = ["arn:aws:logs:us-west-2:${data.aws_caller_identity.current.account_id}:log-group:/${var.scheduler_log_group_name}:*"]
    }

    statement {
      actions = [
        "s3:List*",
        "s3:PutObject*",
        "s3:GetObject*"
      ]
      resources = ["arn:aws:s3:::cloud-custodian*"]
    }
    statement {
      actions = [
        "sqs:ReceiveMessage*",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ]
      resources = ["arn:aws:sqs:us-west-2:${data.aws_caller_identity.current.account_id}:cloud-custodian*"]
    }
}