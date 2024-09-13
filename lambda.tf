resource "aws_iam_policy" "policy" {
  name = "backend-videopoint-lambda-policy"
  policy = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "ReadWriteDynamoDB"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem", 
      "dynamodb:PutItem"
    ]
    resources = [
      aws_dynamodb_table.table.arn
    ]
  }

  statement {
    sid    = "AllowLogging"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"] # Consider scoping this down to specific log groups
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
    statement {
      effect = "Allow"
      actions = ["sts:AssumeRole"]
    
     principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
    name = "backend-videopoint-lambda-role"
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "policy_attachement" {
    role = aws_iam_role.role.name
    policy_arn = aws_iam_policy.policy.arn
}