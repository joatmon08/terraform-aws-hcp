data "aws_iam_policy_document" "boundary" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectAttributes"
    ]
    resources = ["${aws_s3_bucket.boundary.arn}/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:DescribeKey"
    ]
    resources = [aws_kms_key.boundary.arn]
  }
}

resource "aws_iam_policy" "boundary" {
  name_prefix = "${var.name}-boundary-bucket-"
  description = "Policy for Boundary session recording"
  policy      = data.aws_iam_policy_document.boundary.json
}