module "sqs_test" {
  source      = "./modules/sqs"
  sqs_name    = var.sqs_name
#   environment = var.environment
}