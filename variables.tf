variable "api_gateway_name" {
  type        = string
  description = "Nazwa API Gateway"
  sensitive   = false
  nullable    = true
}

variable "lambda_payload_version" {
  type        = string
  description = "wersja zwrotki funkcji lambda"
  default     = "2.0"
  nullable    = false
}

variable "api_gateway_route_get" {
  type = object({
    http_method = string
    route       = string
  })
  description = "Ścieżka API GET (obiekt zawierający http_method i route)"
  nullable    = false
}

variable "api_gateway_route_post" {
  type = object({
    http_method = string
    route       = string
  })
  description = "Ścieżka API POST (obiekt zawierający http_method i route)"
  nullable    = false
}

variable "dynamodb_name" {
  type        = string
  description = "Nazwa DynamoDB"
  nullable    = false

}
variable "dynamodb_hash_key" {
  type        = string
  description = "Klucz główny Dynamodb"
  nullable    = false
}

variable "dynamodb_read_capacity" {
  type        = number
  description = "Ilość odczytów DynamoDB"
  nullable    = false
  default     = 1
}

variable "dynamodb_write_capacity" {
  type        = number
  description = "Ilość zapisów DynamoDB"
  nullable    = false
  default     = 1
}

variable "lambda_policy" {
  type        = string
  description = "Nazwa polityki uzywanej przez funkcję lambda"
  nullable    = false

}

variable "lambda_role" {
  type        = string
  description = "Nazwa execution role lambdy"
  nullable    = false
}

variable "lambda_source_dir" {
  type        = string
  description = "Ściezka do funkcji lambda"
  nullable    = false

}
variable "lambda_source_file_name" {
  type        = string
  description = "Nazwa ZIp z kodem lambda"
  nullable    = false
  default     = "lambda_source"

}
variable "lambda_function_name" {
  type        = string
  description = "Nazwa funkcji lambda"
  nullable    = false

}
variable "lambda_handler" {
  type        = string
  description = "Uchwyt funkcji lambda"
  nullable    = false

}

variable "s3_bucket_name" {
  type        = string
  description = "Nazwa S3 bucket"
  nullable    = false

}

variable "s3_public_access_block" {
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  description = "Blok publicznego dostepu S3"
  nullable    = false
  default = {
    block_public_acls       = true
    block_public_policy     = false
    ignore_public_acls      = true
    restrict_public_buckets = false
  }

}