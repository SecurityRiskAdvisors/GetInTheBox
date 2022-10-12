terraform {
  required_version = ">= 0.13.1"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }

    restapi = {
      source  = "mastercard/restapi"
      version = ">= 0.1.4"
    }
  }
}