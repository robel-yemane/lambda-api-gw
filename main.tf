### following this tutorial:  https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html
# and then try: https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws

resource "random_pet" "lambda_bucket_name" {
  prefix = "learn-tf-func"
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
  source_dir  = "${path.module}/hello-world"
  output_path = "${path.module}/hello-world.zip"
}

resource "aws_s3_object" "lambda_hello_world" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello-world.zip"
  source = data.archive_file.lambda_hello_world.output_path
  etag   = filemd5(data.archive_file.lambda_hello_world.output_path)
}


// create lambda func
module "lambda_function" {
  source            = "./modules/lambda"
  function_name     = "HelloWorld"
  s3_bucket_id      = aws_s3_bucket.lambda_bucket.id
  s3_key            = aws_s3_object.lambda_hello_world.key
  handler           = "hello.handler"
  source_code_hash  = data.archive_file.lambda_hello_world.output_base64sha256
  retention_in_days = "30"
}

// create api gateway
module "api_gateway" {
  source = "./modules/api-gw"
  name = "serverless_lambda_gw"
  stage_name = "serverless_lambda_stage"
}

