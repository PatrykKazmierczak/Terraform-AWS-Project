# Define a DynamoDB table resource
resource "aws_dynamodb_table" "table" {
  name         = "comments"          # Name of the DynamoDB table
  hash_key     = "mail"              # The primary key (hash key) for the table

  # Define the attributes used in the table
  attribute {
    name = "mail"      # Name of the attribute (hash key)
    type = "S"         # Type of the attribute ('S' for String)
  }

  # Set the billing mode for the table
  billing_mode = "PROVISIONED"  # Provisioned mode for specifying read and write capacity

  # Define the read and write capacity units
  read_capacity  = 1  # Number of read capacity units (adjust based on expected workload)
  write_capacity = 1  # Number of write capacity units (adjust based on expected workload)
}
