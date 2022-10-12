provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "restapi" {
  uri                  = "https://api.cloudflare.com/"
  debug                = true
  write_returns_object = true
  headers = {
    X-Auth-Email = var.cloudflare_email
    X-Auth-Key   = var.cloudflare_api_key
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  default_tags {
    tags {
      Name = "[${var.project}] Red Swarm"
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
  
  default_tags {
    tags {
      Name = "[${var.project}] Red Swarm"
    }
  }
}


provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}


provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "california"
  region = "us-west-1"
}


provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

provider "aws" {
  alias  = "oregon"
  region = "us-west-2"
}

provider "aws" {
  alias  = "af-south-1"
  region = "af-south-1"
}

provider "aws" {
  alias  = "capetown"
  region = "af-south-1"
}

provider "aws" {
  alias  = "ap-east-1"
  region = "ap-east-1"
}

provider "aws" {
  alias  = "hongkong"
  region = "ap-east-1"
}

provider "aws" {
  alias  = "ap-southeast-3"
  region = "ap-southeast-3"
}
provider "aws" {
  alias  = "jakarta"
  region = "ap-southeast-3"
}

provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "ap-northeast-3"
  region = "ap-northeast-3"
}

provider "aws" {
  alias  = "osaka"
  region = "ap-northeast-3"
}

provider "aws" {
  alias  = "ap-northeast-2"
  region = "ap-northeast-2"
}

provider "aws" {
  alias  = "seoul"
  region = "ap-northeast-2"
}


provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "singapore"
  region = "ap-southeast-1"
}


provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}

provider "aws" {
  alias  = "ap-northeast-1"
  region = "ap-northeast-1"
}

provider "aws" {
  alias  = "tokyo"
  region = "ap-northeast-1"
}

provider "aws" {
  alias  = "ca-central-1"
  region = "ca-central-1"
}

provider "aws" {
  alias  = "canada"
  region = "ca-central-1"
}

provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "ireland"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "eu-west-3"
  region = "eu-west-3"
}

provider "aws" {
  alias  = "paris"
  region = "eu-west-3"
}

provider "aws" {
  alias  = "eu-south-1"
  region = "eu-south-1"
}

provider "aws" {
  alias  = "milan"
  region = "eu-south-1"
}

provider "aws" {
  alias  = "eu-north-1"
  region = "eu-north-1"
}

provider "aws" {
  alias  = "stockholm"
  region = "eu-north-1"
}

provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
}

provider "aws" {
  alias  = "frankfurt"
  region = "eu-central-1"
}

provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}

provider "aws" {
  alias  = "saopaulo"
  region = "sa-east-1"
}

provider "aws" {
  alias  = "me-south-1"
  region = "me-south-1"
}

provider "aws" {
  alias  = "bahrain"
  region = "me-south-1"
}
