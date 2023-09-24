variable "sqs_name" {
  type = map(object({
    name        = string
    environment = string
  }))
  default = {
    "poc-edu-dev" = {
      name        = "poc-edu-dev"
      environment = "dev"
    },
    "poc-edu-qa" = {
      name        = "poc-edu-qa"
      environment = "qa"
    },
    "poc-edu-uat" = {
      name        = "poc-edu-uat"
      environment = "uat"
    }
  }
}