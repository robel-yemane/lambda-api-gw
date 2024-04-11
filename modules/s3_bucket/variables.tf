# modules/s3_bucket/variables.tf
variable "bucket_prefix" {
  type    = string
  description = "value to prefix the bucket name with"
  default = "learn-tf-func"
}