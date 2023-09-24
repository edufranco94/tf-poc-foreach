resource "aws_sqs_queue" "terraform_queue" {
  for_each                  = var.sqs_name
  name                      = each.value["name"]
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Name        = each.value["name"]
    Environment = each.value["environment"]

  }
}