output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.hello_world.name
}

output "function_url" {
  value = data.aws_lambda_function_url.hello_world.function_url

}