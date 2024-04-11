variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-west-1"

}

variable "bucket_prefix" {
  type        = string
  description = "value to prefix the bucket name with"
  default     = "learn-tf-func"
}