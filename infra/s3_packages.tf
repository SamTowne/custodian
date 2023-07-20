resource "aws_s3_bucket" "cloud_custodian_lambda_packages" {
  bucket = "cloud-custodian-lambda-packages-272773485930"
}

resource "aws_s3_bucket_acl" "cloud_custodian_lambda_packages" {
  bucket = aws_s3_bucket.cloud_custodian_lambda_packages.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloud_custodian_lambda_packages" {
  bucket = aws_s3_bucket.cloud_custodian_lambda_packages.bucket
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

data "aws_iam_policy_document" "cloud_custodian_lambda_packages" {
  statement {
    sid = "Console/Service role list access"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["s3:List*"]
    resources = ["arn:aws:s3:::cloud-custodian-lambda-packages-272773485930"]
  }

  statement {
    sid = "Deployment service object access"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::272773485930:role/custodian-272773485930-github-oidc"]
    }
    actions = [
      "s3:PutObject*",
      "s3:GetObject*",
    ]
    resources = ["arn:aws:s3:::cloud-custodian-lambda-packages-272773485930"]
  }
}