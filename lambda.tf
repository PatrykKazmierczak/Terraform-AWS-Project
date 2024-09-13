# Define an IAM policy with permissions for Lambda functions
resource "aws_iam_policy" "policy" {
  name   = "backend-videopoint-lambda-policy"  # Name of the IAM policy
  policy = data.aws_iam_policy_document.policy.json  # JSON policy document that defines the permissions
}

# Create an IAM policy document defining permissions for DynamoDB and CloudWatch Logs
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "ReadWriteDynamoDB"  # Statement ID for identification
    effect = "Allow"              # Allow the specified actions
    actions = [
      "dynamodb:ScanItem",        # Allow read operations on DynamoDB
      "dynamodb:PutItem",         # Allow write operations on DynamoDB
      "dynamodb:GetItem"         # Allow write operations on DynamoDB
    ]
    resources = [
      aws_dynamodb_table.table.arn  # Reference to the DynamoDB table for which these actions are allowed
    ]
  }

  statement {
    sid    = "AllowLogging"     # Statement ID for identification
    effect = "Allow"           # Allow the specified actions
    actions = [
      "logs:CreateLogGroup",  # Allow creating new CloudWatch log groups
      "logs:CreateLogStream", # Allow creating new log streams in CloudWatch
      "logs:PutLogEvents"     # Allow putting log events to CloudWatch
    ]
    resources = ["*"]          # Allow these actions on any CloudWatch log group (consider scoping this down for security)
  }
}

# Create an IAM policy document that allows Lambda to assume this role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"           # Allow the specified actions
    actions = ["sts:AssumeRole"]  # Allow assuming this IAM role
    
    principals {
      type        = "Service"   # Type of principal that can assume the role
      identifiers = ["lambda.amazonaws.com"]  # AWS Lambda service is allowed to assume the role
    }
  }
}

# Define an IAM role for Lambda with the specified assume role policy
resource "aws_iam_role" "role" {
  name                 = "backend-videopoint-lambda-role"  # Name of the IAM role
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json  # JSON policy document for assuming the role
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role      = aws_iam_role.role.name  # Reference to the IAM role
  policy_arn = aws_iam_policy.policy.arn  # ARN of the IAM policy to be attached
}

data "archive_file" "lambda_package" {
  type        = "zip"               # Type of archive to create
  output_path = "./backend.zip"     # Path to save the ZIP file
  source_dir  = "../backend"         # Directory containing files to include in the ZIP file
}

resource "aws_lambda_function" "lambda_function" {
  filename = "./backend.zip"
  function_name = "backend_videopoint"
  role = aws_iam_role.role.arn
  handler = "main.handler"

  runtime = "python3.8"

  environment {
    variables = {
      "key" = aws_dynamodb_table.table.name
    }
  }
}

