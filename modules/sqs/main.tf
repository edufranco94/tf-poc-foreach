resource "aws_sqs_queue" "terraform_queue" {
  count                     = length(var.environment)
  name                      = "${var.sqs_name}-${var.environment[count.index]}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Name        = "${var.sqs_name}-${var.environment[count.index]}"
    Environment = var.environment[count.index]
  }
}