resource "aws_iam_role" "boundary" {
  name_prefix = var.name
  path        = "/hcp/boundary/worker/${var.name}/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_iam_instance_profile" "boundary" {
  name_prefix = var.name
  role        = aws_iam_role.boundary.name
}

resource "aws_iam_role_policy_attachment" "boundary" {
  for_each   = var.additional_policy_arns
  role       = aws_iam_role.boundary.name
  policy_arn = each.key
}