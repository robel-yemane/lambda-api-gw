output "cloudwatch_log_group_name" {
  value = module.lambda_function.cloudwatch_log_group_name
}

output "lambda_function_name" {
  value = module.lambda_function.function_name

}

output "lambda_invoke_arn" {
  value = module.lambda_function.invoke_arn
}

output "base_url" {
  value = module.api_gateway.base_url
  
}