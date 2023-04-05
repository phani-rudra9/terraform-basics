terraform {
  backend "s3" {
    bucket = "terraform-state-demonew"
    key    = "terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}
