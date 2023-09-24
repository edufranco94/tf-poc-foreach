variable "sqs_name" {
  type = map(object({
    name        = string
    environment = string
  }))
}