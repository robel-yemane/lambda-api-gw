# create lambda func

resource "aws_lambda_function" "hello_world" {
  function_name = var.name
  s3_bucket     = var.s3_bucket_id
  s3_key        = var.s3_key
  runtime       = var.runtime
  handler       = var.handler
  #source_code_hash = var.source_code_hash
  role = aws_iam_role.lambda_exec.arn
  
  
}

# No need to create a lambda function url
# API Gateway will create a URL for us

# # create lambda function url
# resource "aws_lambda_function_url" "hello_world" {
#   function_name = aws_lambda_function.hello_world.function_name
#   #TODO: look if best authorised via IAM role
#   authorization_type = "NONE"
# }

# #fetch lambda func url
# data "aws_lambda_function_url" "hello_world" {
#   depends_on    = [aws_lambda_function_url.hello_world]
#   function_name = aws_lambda_function.hello_world.function_name
# }
