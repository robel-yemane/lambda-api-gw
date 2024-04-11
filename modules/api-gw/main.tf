resource "aws_apigatewayv2_api" "this" {
    name         = var.name
    protocol_type = var.protocol
}

resource "aws_apigatewayv2_stage" "this" {
    api_id = aws_apigatewayv2_api.this.id
    name = var.stage_name
    auto_deploy = var.auto_deploy

    access_log_settings {
      destination_arn = aws_cloudwatch_log_group.this.arn
      format = jsonencode({
        requestId = "$context.requestId",
        ip = "$context.identity.sourceIp",
        user = "$context.identity.user",
        requestTime = "$context.requestTime",
        httpMethod = "$context.httpMethod",
        resourcePath = "$context.resourcePath",
        status = "$context.status",
        protocol = "$context.protocol",
        responseLength = "$context.responseLength"
      })
    }

}