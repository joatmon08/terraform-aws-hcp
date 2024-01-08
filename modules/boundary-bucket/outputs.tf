output "policy_arn" {
  value = aws_iam_policy.boundary.arn
}

output "bucket_name" {
  value = aws_s3_bucket.boundary.bucket
}