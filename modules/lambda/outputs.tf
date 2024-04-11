output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.hello_world.name
}

output "function_name" {
  value = aws_lambda_function.hello_world.function_name
}