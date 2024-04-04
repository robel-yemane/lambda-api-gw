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

