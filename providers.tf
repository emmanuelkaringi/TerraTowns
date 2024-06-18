terraform {
  # Migrating to cloud
#   cloud {
#     organization = "Vertives"
#     workspaces {
#       name = "terra-house-1"
#     }
#   }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
     aws = {
      source = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "random" {
  # Configuration options
}
provider "aws" {
  # Configuration options
}