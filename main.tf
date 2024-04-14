### following this tutorial:  https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html
# and then try: https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws

module "lambda_s3_bucket" {
  source        = "./modules/s3_bucket"
  bucket_prefix = var.bucket_prefix
}

// create lambda func
module "lambda_function" {
  source       = "./modules/lambda"
  name         = "HelloWorld"
  s3_bucket_id = module.lambda_s3_bucket.s3_bucket_id
  s3_key       = module.lambda_s3_bucket.s3_key
  handler      = "hello.handler"
  #source_code_hash  = data.archive_file.lambda_hello_world.output_base64sha256
  retention_in_days = "30"
}

# // create api gateway
# module "api_gateway" {
#   source = "./modules/apigw"
#   name = "serverless_lambda_gw"
#   stage_name = "serverless_lambda_stage"
#   auto_deploy = true
#   lambda_function_invoke_arn = module.lambda_function.invoke_arn
#   route_key = "GET /hello"
#   lambda_function_name =  module.lambda_function.name
#   lambda_execution_arn = "${module.lambda_function.execution_arn}/*/*"
# }

// create api gateway


module "api_gateway" {
  depends_on = [module.lambda_function]

  source               = "./modules/apigw"
  lambda_function_name = module.lambda_function.function_name
  lambda_function_invoke_arn   = module.lambda_function.invoke_arn
}
