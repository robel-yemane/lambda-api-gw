variable "lambda_function_name" {
  description = "The name of the lambda function"
  type        = string
  
}

variable "lambda_function_invoke_arn" {
  description = "The ARN to be used for invoking the lambda function"
  type        = string
}