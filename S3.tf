# Create an S3 bucket named "fronted-videopoint"
resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name  # Name of the S3 bucket
}

# Define public access block configuration for the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id  # Reference to the S3 bucket created above

  # Block public access to the bucket
  block_public_acls       = var.s3_public_access_block.block_public_acls
  block_public_policy     = var.s3_public_access_block.block_public_policy
  ignore_public_acls      = var.s3_public_access_block.ignore_public_acls
  restrict_public_buckets = var.s3_public_access_block.restrict_public_buckets
}

# Create an IAM policy document that allows public read access to the S3 bucket
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "AllowPublic"  # Statement ID for identification
    effect = "Allow"       # Allow the specified actions
    actions = ["s3:GetObject"]  # Allow read access to objects in the bucket
    resources = ["${aws_s3_bucket.bucket.arn}/*"]  # Apply policy to all objects in the bucket
    principals {
      type = "*"  # Apply to any principal (user or service)
      identifiers = ["*"]  # Allow access to everyone
    }
  }
}

# Attach the policy to the S3 bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id  # Reference to the S3 bucket created above
  policy = data.aws_iam_policy_document.bucket_policy.json  # JSON representation of the IAM policy document
}
