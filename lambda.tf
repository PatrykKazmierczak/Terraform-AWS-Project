# Define an IAM policy with permissions for Lambda functions
# resource "aws_iam_policy" "policy" {
#   name   = var.lambda_policy                        # Name of the IAM policy
#   policy = data.aws_iam_policy_document.policy.json # JSON policy document that defines the permissions
# }

# # Create an IAM policy document defining permissions for DynamoDB and CloudWatch Logs
# data "aws_iam_policy_document" "policy" {
#   dynamic "statement" {
#     for_each = local.lambda_policy
#   content {
#     sid    = statement.key # Statement ID for identification
#     effect = statement.value.effect             # Allow the specified actions
#     actions = statement.value.actions
#     resources = statement.value.resources
#     }
#   }
# }

module "lambda_policy" {
  source = "./modules/iam_policy"

  name = var.lambda_policy
  statements = local.lambda_policy
  
}
# Create an IAM policy document that allows Lambda to assume this role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"            # Allow the specified actions
    actions = ["sts:AssumeRole"] # Allow assuming this IAM role

    principals {
      type        = "Service"                # Type of principal that can assume the role
      identifiers = ["lambda.amazonaws.com"] # AWS Lambda service is allowed to assume the role
    }
  }
}

# Define an IAM role for Lambda with the specified assume role policy
resource "aws_iam_role" "role" {
  name               = var.lambda_role                                      # Name of the IAM role
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json # JSON policy document for assuming the role
}

# Attach the IAM policy to the IAM role
# resource "aws_iam_role_policy_attachment" "policy_attachment" {
#   role       = aws_iam_role.role.name    # Reference to the IAM role
#   policy_arn = aws_iam_policy.policy.arn # ARN of the IAM policy to be attached
# }

data "archive_file" "lambda_package" {
  type        = "zip"                                  # Type of archive to create
  output_path = "./${var.lambda_source_file_name}.zip" # Path to save the ZIP file
  source_dir  = var.lambda_source_dir                  # Directory containing files to include in the ZIP file
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "./${var.lambda_source_file_name}.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.role.arn
  handler          = var.lambda_handler
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  runtime          = "python3.8"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.table.name
    }
  }
}

resource "aws_lambda_permission" "resource_based_policy" {
  statement_id  = "HTTPApiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name # Correct reference
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*"
}


