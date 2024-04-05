output "cloudwatch_log_group_name" {
  value = module.lambda_function.cloudwatch_log_group_name
}

output "lambda_function_name" {
  value = module.lambda_function.function_name

}