resource "aws_dynamodb_table" "this" {
  name         = var.aws_dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }

  tags = {
    Name = "${local.resource_prefix_name}-${var.aws_dynamodb_table_name}"
  }
}