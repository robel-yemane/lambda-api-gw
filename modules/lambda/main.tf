# create lambda func

resource "aws_lambda_function" "hello_world" {
  depends_on       = [aws_cloudwatch_log_group.hello_world]
  function_name    = var.function_name
  s3_bucket        = var.s3_bucket_id
  s3_key           = var.s3_key
  runtime          = var.runtime
  handler          = var.handler
  source_code_hash = var.source_code_hash
  role             = aws_iam_role.lambda_exec.arn
}


# create lambda function url
resource "aws_lambda_function_url" "hello_world" {
  function_name = aws_lambda_function.hello_world.function_name
  #TODO: look if best authorised via IAM role
  authorization_type = "NONE"
}

#fetch lambda func url
data "aws_lambda_function_url" "hello_world" {
  function_name = aws_lambda_function.hello_world.function_name
}

# cloudwatch log group
resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.retention_in_days
}

# iam role for lambda
resource "aws_iam_role" "lambda_exec" {
    name = "serverless_lambda"

    assume_role_policy = jsonencode({
        "Version": "2012-10-17",  
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }) 
}

# iam role policy attachment
resource "aws_iam_role_policy_attachment" "lambda_policy" {
    role = aws_iam_role.lambda_exec.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}