resource "aws_iam_role" "configurator" {
    name = "cloud_custodian_configurator"
    assume_role_policy = data.aws_iam_policy_document.configurator_trust.json
}

resource "aws_iam_role_policy" "configurator" {
    name = "cloud_custodian_configurator"
    role = aws_iam_role.configurator.id
    policy = data.aws_iam_policy_document.configurator_policy.json
}

data "aws_iam_policy_document" "configurator_trust" {
    statement {
      actions = ["sts:AssumeRole"]

      principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
}

data "aws_iam_policy_document" "configurator_policy" {
    statement {
      actions = [
        "logs:CreateLogStream",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents"
      ]

      resources = ["arn:aws:logs:us-west-2:${data.aws_caller_identity.current.account_id}:log-group:/${var.configurator_log_group_name}:*"]
    }

    statement {
      actions = [
        "dynamodb:BatchWriteItem",
        "dynamodb:DeleteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
      ]
      resources = [
        "arn:aws:dynamodb:*:${data.aws_caller_identity.current.account_id}:cloud-custodian*",
        "arn:aws:dynamodb:*:${data.aws_caller_identity.current.account_id}:cloud_custodian*"
      ]
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