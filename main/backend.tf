terraform {
  backend "s3" {
    bucket         = #backend name
    dynamodb_table = "terraform-state-locking"
    region         = "us-east-1"
    key            = "backend.tfstate"
    profile        = "hur-terraform"
  }
}