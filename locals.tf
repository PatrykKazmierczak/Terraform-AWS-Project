locals {
  mime_types = {
    html = "text/html"
    css  = "text/css"
    js   = "text/javascript"
  }

  lambda_policy = {
    ReadWriteDynamoDB = {
      effect = "Allow" # Specify the effect explicitly
      actions = [
        "dynamodb:Scan",   # Allow read operations on DynamoDB         
        "dynamodb:GetItem" # Allow reading individual items from DynamoDB
      ]
      resources = [
        aws_dynamodb_table.table.arn # Reference to the DynamoDB table for which these actions are allowed
      ]
    }

    AllowLogging = {
      effect = "Allow" # Allow the specified actions
      actions = [
        "logs:CreateLogGroup",  # Allow creating new CloudWatch log groups
        "logs:CreateLogStream", # Allow creating new log streams in CloudWatch
        "logs:PutLogEvents"     # Allow putting log events to CloudWatch
      ]
      resources = ["*"] # Apply to all resources
    }
  }
}
