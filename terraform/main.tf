# swarm itself
module "swarm" {
  source = "./modules/swarm"

  project          = var.project
  ingress_ip_cidrs = var.ingress_ip_cidrs

  num_managers = var.num_managers
  num_workers  = var.num_workers

  providers = {
    # set your target region
    aws        = aws.us-east-2
    cloudflare = cloudflare
  }
}

/*
# cloudfront redirectors
module "cloudfront_c2_sliver" {
    # static
    source = "./modules/cloudfront_c2"
    project = var.project

    # total number of CF distros to create
    num_distros = 1

    # C2 origin info that CF should route to
    c2_domain = "sliver-demo.buzzsaw.dev"
    c2_port = 443

    # pick your region
    providers = {
        aws = aws.eu-west-2
    }
}

module "cloudfront_c2_nh" {
    # static
    source = "./modules/cloudfront_c2"
    project = var.project

    # total number of CF distros to create
    num_distros = 1

    # C2 origin info that CF should route to
    c2_domain = "nighthawk-demo.buzzsaw.dev"
    c2_port = 443

    # pick your region
    providers = {
        aws = aws.eu-central-1
    }
}
*/
