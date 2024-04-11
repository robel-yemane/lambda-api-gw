resource "random_pet" "lambda_bucket_name" {
  prefix = var.bucket_prefix
  length = 4
}

# Create an S3 bucket for the Lambda function
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id
}

# Enable bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Set the bucket ACL to private
resource "aws_s3_bucket_acl" "lambda_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.lambda_bucket]
  bucket     = aws_s3_bucket.lambda_bucket.id
  acl        = "private"
}

# package and copy hello-world func to the s3 bucket
data "archive_file" "lambda_hello_world" {
  type        = "zip"
  source_dir  = "${path.root}/hello-world"
  output_path = "${path.root}/hello-world.zip"
}

resource "aws_s3_object" "lambda_hello_world" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello-world.zip"
  source = data.archive_file.lambda_hello_world.output_path
  etag   = filemd5(data.archive_file.lambda_hello_world.output_path)
}
