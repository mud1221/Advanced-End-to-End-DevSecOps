terraform {
  backend "s3" {
    bucket         = "mudasir-terraform-state"
    key            = "jenkins/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}