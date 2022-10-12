locals {
    all_ips = concat([module.swarm.primary_manager_node_ip], module.swarm.secondary_manager_node_ips, module.swarm.worker_node_ips)
}

module "cloudflare_traefik" {
  count = var.enable_traefik ? 1 : 0
  source      = "./modules/cloudflare_dns"
  root_domain = var.root_domain
  subdomain = var.traefik_ui_domain
  ip_addresses = local.all_ips
}

module "cloudflare_portainer" {
  count = var.enable_portainer ? 1 : 0
  source      = "./modules/cloudflare_dns"
  root_domain = var.root_domain
  subdomain = var.portainer_ui_domain
  ip_addresses = local.all_ips
}

module "cloudflare_fileserver_nginx" {
  count = var.enable_fileserver ? 1 : 0
  source      = "./modules/cloudflare_dns"
  root_domain = var.root_domain
  subdomain = var.fileserver_nginx_domain
  ip_addresses = local.all_ips
}

module "cloudflare_fileserver_ssh" {
  count = var.enable_fileserver ? 1 : 0
  source      = "./modules/cloudflare_dns"
  root_domain = var.root_domain
  subdomain = var.fileserver_ssh_domain
  ip_addresses = local.all_ips
}

module "cloudflare_cs_teamserver" {
  count = var.enable_cs ? 1 : 0
  source      = "./modules/cloudflare_dns"
  root_domain = var.root_domain
  subdomain = var.cs_teamserver_domain
  ip_addresses = local.all_ips
}

module "cloudflare_cs_profile" {
  count = var.enable_cs ? length(var.cs_profile_domains) : 0
  source      = "./modules/cloudflare_dns"
  root_domain = var.root_domain
  subdomain = var.cs_profile_domains[count.index]
  ip_addresses = local.all_ips
}