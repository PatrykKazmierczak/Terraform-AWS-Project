resource "aws_s3_bucket" "bucket" {
    bucket = "fronted-videopoint"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {

    bucket = aws_s3_bucket.bucket.id

    block_public_acls       = true
    block_public_policy     = false
    ignore_public_acls      = true
    restrict_public_buckets = false
}

data "aws_iam_policy_document" "bucket_policy" {
    statement {
      sid = "AllowPublic"
      effect = "Allow"
      actions = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.bucket.arn}/*"]
      principals {
        type = "*"
        identifiers = ["*"]
      }
    }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.bucket.id
    policy = data.aws_iam_policy_document.bucket_policy.json
  
}