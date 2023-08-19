terraform {
  backend "s3" {
    bucket         = "rahnuma-terraform-bucket"
    dynamodb_table = "terraform-state-locking"
    region         = "us-east-1"
    key            = "backend.tfstate"
    profile        = "hur-terraform"
  }
}