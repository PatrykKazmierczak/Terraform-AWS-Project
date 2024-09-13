resource "aws_dynamodb_table" "table" {
    name = "comments"
    hash_key = "mail"

    attribute {
      name = "mail"
      type = "S"
    }

    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
  
}