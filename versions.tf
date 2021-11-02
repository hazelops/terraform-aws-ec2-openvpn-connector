terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    template = {
      source = "hashicorp/template"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 1.2"
    }
  }
  required_version = ">= 0.13"
}
