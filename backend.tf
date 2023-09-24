terraform {
  backend "s3" {
    bucket = "descomplicando-terraform-edufranco"
    key    = "poc-foreach/terraform.tfstate"
    region = "us-east-1"
  }
}