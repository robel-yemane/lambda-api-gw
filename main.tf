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
  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}
  
# package and copy hello-world func to the s3 bucket
data "archive_file" "lambda_hello_world" {
  type = "zip"
  source_dir = "${path.module}/hello-world"
  output_path = "${path.module}/hello-world.zip"
}

resource "aws_s3_object" "lambda_hello_world" {
  bucket = aws_s3_bucket.lambda_bucket.id 

  key = "hello-world.zip"
  source = data.archive_file.lambda_hello_world.output_path
  etag = filemd5(data.archive_file.lambda_hello_world.output_path)
}


####################################################################
# #Lambda Func
# resource "aws_lambda_function" "get_started_lambda" {
#   function_name = "GetStartedLambdaFunc"
#   role          = aws_iam_role.lambda_execution_role.arn
#   handler       = "func.lambda_handler"
#   runtime       = "python3.8"

#   source_code_hash = data.archive_file.lambda_code.output_base64sha256
#   filename         = data.archive_file.lambda_code.output_path
# }

# data "archive_file" "lambda_code" {
#   type        = "zip"
#   output_path = "${path.module}/lambda_function.zip"
#   source {
#     content  = file("${path.module}/func.py")
#     filename = "func.py"
#   }
# }


# resource "aws_iam_role" "lambda_execution_role" {
#   name               = "GetStartedLambdaBasicExecutionRole"
#   assume_role_policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#         "Effect": "Allow",
#         "Principal": {
#             "Service": "lambda.amazonaws.com"
#         },
#         "Action": "sts:AssumeRole"
#         }
#     ]

# }
# EOF
# }
# resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
#   role       = aws_iam_role.lambda_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

# }



