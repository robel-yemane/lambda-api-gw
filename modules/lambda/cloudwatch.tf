# cloudwatch log group
resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.retention_in_days
}