terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.51.1"
    }
  }
  required_version = "1.7.2"
}
