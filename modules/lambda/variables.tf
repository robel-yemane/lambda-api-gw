variable "function_name" {
  description = "The name of the lambda function"
  type        = string
}
variable "s3_bucket_id" {
  description = "The id of the S3 bucket to store the lambda function code"
  type        = string
}
variable "s3_key" {
  description = "The key of the S3 object that contains the lambda function code"
  type        = string
}
variable "runtime" {
  description = "The runtime to use for the lambda function"
  type        = string
  default     = "nodejs20.x"
}
variable "handler" {
  description = "The handler function to use for the lambda function"
  type        = string
}
# variable "source_code_hash" {
#   description = "The base64-encoded SHA256 hash of the lambda function code"
#   type        = string
# }

# cloudwatch log group
variable "retention_in_days" {
  description = "The number of days to retain log events in the CloudWatch log group"
  type        = number
  default     = 30
}

