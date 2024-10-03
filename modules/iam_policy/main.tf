resource "aws_iam_policy" "policy" {
  name   = var.name                     # Name of the IAM policy
  policy = data.aws_iam_policy_document.policy.json # JSON policy document that defines the permissions
}

# Create an IAM policy document defining permissions for DynamoDB and CloudWatch Logs
data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.statements
  content {
    sid    = statement.key # Statement ID for identification
    effect = statement.value.effect             # Allow the specified actions
    actions = statement.value.actions
    resources = statement.value.resources
    }
  }
}