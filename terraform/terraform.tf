terraform {
    required_version = ">= 0.13"

    required_providers {
        aws = {
            source = "hashicorp/aws"
        }

        tls = {
            source = "hashicorp/tls"
        }

        cloudflare = {
            source = "cloudflare/cloudflare"
        }

        restapi = {
            source = "mastercard/restapi"
        }
    }
}
