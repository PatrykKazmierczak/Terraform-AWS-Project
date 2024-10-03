resource "aws_apigatewayv2_api" "api" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["http://${aws_s3_bucket_website_configuration.website.website_endpoint}"]
  }
}

resource "aws_apigatewayv2_integration" "integration" {
  api_id                 = aws_apigatewayv2_api.api.id
  integration_type       = "AWS_PROXY"
  connection_type        = "INTERNET"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.lambda_function.invoke_arn
  payload_format_version = var.lambda_payload_version
}

resource "aws_apigatewayv2_route" "route_get" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "${var.api_gateway_route_get.http_method} ${var.api_gateway_route_get.route}"
  target    = "integrations/${aws_apigatewayv2_integration.integration.id}"
}

resource "aws_apigatewayv2_route" "route_post" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "${var.api_gateway_route_post.http_method} ${var.api_gateway_route_post.route}"
  target    = "integrations/${aws_apigatewayv2_integration.integration.id}"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}

