### following this tutorial:  https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html
# and then try: https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws

resource "random_pet" "lambda_bucket_name" {
  prefix = "learn-tf-func"
  length = 4
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id 
}

resource "aws_s3_bucket_ownership_controls" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }

}

resource "aws_s3_bucket_acl" "lambda_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.lambda_bucket]
  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}
  

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



