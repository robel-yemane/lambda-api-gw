#  s3_bucket_id      = aws_s3_bucket.lambda_bucket.id
  #  s3_bucket_id      = aws_s3_bucket.lambda_bucket.id

output s3_bucket_id {
  value = aws_s3_bucket.lambda_bucket.id
}

output s3_key {
  value = aws_s3_object.lambda_hello_world.key
} 