output "sqs_url" {
  value = {
    for k, v in aws_sqs_queue.terraform_queue:
    k => v.url
  }
}