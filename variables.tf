variable "sqs_name" {
  type    = string
  default = "poc-edu"
}
variable "environment" {
  type    = list(string)
  default = ["dev", "qa", "uat"]
}

variable "count_sqs" {
    type = number
    default = null 
}