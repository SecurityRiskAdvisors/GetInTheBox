## Generic Vars

project            = "demo"
cloudflare_email   = "foo@bar.com"
cloudflare_api_key = "abc123"
ingress_ip_cidrs = [
  "10.10.10.10/32",
  "10.10.10.0/24"
]
num_managers = 1
num_workers  = 1
root_domain  = "totally.legit"

## Traefik Vars
enable_traefik    = true
traefik_ui_domain = "traefik"

## Portainer Vars
enable_portainer    = true
portainer_ui_domain = "portainer"

## Fileserver Vars
enable_fileserver       = true
fileserver_nginx_domain = "cdn"
fileserver_route_prefix = "/static"
fileserver_ssh_domain   = "fileserver"
fileserver_ssh_username = "blacksmith"

## Cobaltstrike Vars
enable_cs            = true
cs_image_name        = "9999999999.dkr.ecr.us-east-1.amazonaws.com/cobaltstrike:latest"
cs_license           = "x-x-x-x"
cs_expire_date       = "12-31-2022"
cs_profile           = "example.profile"
cs_profile_domains   = ["cs1", "cs2"]
cs_profile_paths     = ["/api1/", "/api2/", "/api3/"]
cs_profile_ua        = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:105.0) Gecko/20100101 Firefox/105.0"
cs_teamserver_domain = "cs"
