terraform {
  required_version = ">=1.14.0"
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = var.aws_region
  
}
resource "aws_cognito_user_pool" "xpix_pool" {
  name = "xpix-user-pool"
}

resource "aws_cognito_user_pool_client" "xpix_client" {
  name         = "xpix-client"                    
  user_pool_id = aws_cognito_user_pool.xpix_pool.id

  
}