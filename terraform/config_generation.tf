# template definitions
locals {
  traefik_domain = format("%s.%s", var.traefik_ui_domain, var.root_domain)
  traefik_content = templatefile("../swarm/templates/traefik.tftpl", { traefik_image_name = var.traefik_image_name, traefik_ui_domain = local.traefik_domain, traefik_admin_password_hash = random_password.admin_password_traefik.bcrypt_hash, root_domain = var.root_domain })

  portainer_domain = format("%s.%s", var.portainer_ui_domain, var.root_domain)
  portainer_content = templatefile("../swarm/templates/portainer.tftpl", { portainer_image_name = var.portainer_image_name, portainer_agent_image_name = var.portainer_agent_image_name, portainer_admin_password_hash = random_password.admin_password_portainer.bcrypt_hash, portainer_ui_domain = local.portainer_domain, root_domain = var.root_domain })

  cs_profile_domains = [for d in var.cs_profile_domains : format("%s.%s", d, var.root_domain)]
  cs_content = templatefile("../swarm/templates/cobaltstrike.tftpl", { cs_image_name = var.cs_image_name, cs_pass = random_password.admin_password_cobaltstrike.result, cs_license = var.cs_license, cs_expire_date = var.cs_expire_date, cs_profile = var.cs_profile, cs_profile_domains = local.cs_profile_domains, cs_profile_paths = var.cs_profile_paths, cs_profile_ua = var.cs_profile_ua, root_domain = var.root_domain })

  fileserver_nginx_domain = format("%s.%s", var.fileserver_nginx_domain, var.root_domain)
  fileserver_content = templatefile("../swarm/templates/fileserver.tftpl", { fileserver_openssh_image_name = var.fileserver_openssh_image_name, fileserver_nginx_image_name = var.fileserver_nginx_image_name, fileserver_nginx_domain = local.fileserver_nginx_domain, fileserver_route_prefix = var.fileserver_route_prefix, fileserver_ssh_pub_key = module.swarm.public_key_openssh, fileserver_ssh_username = var.fileserver_ssh_username, root_domain = var.root_domain })
}

# traefik 

resource "random_password" "admin_password_traefik" {
  length  = 12
  special = false
}

resource "null_resource" "traefik_config" {
  count = var.enable_traefik ? 1 : 0
  triggers = {
    template           = local.traefik_content
    root_domain        = var.root_domain
    traefik_image_name = var.traefik_image_name
    traefik_ui_domain  = var.traefik_ui_domain
  }

  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      var.traefik_output_file,
      local.traefik_content
    )
  }
}

# portainer

resource "random_password" "admin_password_portainer" {
  length  = 12
  special = false
}

resource "null_resource" "portainer_config" {
  count = var.enable_portainer ? 1 : 0

  triggers = {
    template                   = local.portainer_content
    root_domain                = var.root_domain
    portainer_image_name       = var.portainer_image_name
    portainer_agent_image_name = var.portainer_agent_image_name
    portainer_ui_domain        = var.portainer_ui_domain
  }

  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      var.portainer_output_file,
      local.portainer_content
    )
  }
}

# cobaltstrike

resource "random_password" "admin_password_cobaltstrike" {
  length  = 12
  special = false
}

resource "null_resource" "cs_config" {
  count = var.enable_cs ? 1 : 0

  triggers = {
    template           = local.cs_content
    root_domain        = var.root_domain
    cs_image_name      = var.cs_image_name
    cs_license         = var.cs_license
    cs_expire_date     = var.cs_expire_date
    cs_profile         = var.cs_profile
    cs_profile_domains = join(",", var.cs_profile_domains)
    cs_profile_paths   = join(",", var.cs_profile_paths)
    cs_profile_ua      = var.cs_profile_ua
  }

  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      var.cs_output_file,
      local.cs_content
    )
  }
}

# fileserver

resource "null_resource" "fileserver_config" {
  count = var.enable_fileserver ? 1 : 0

  triggers = {
    template                      = local.fileserver_content
    root_domain                   = var.root_domain
    fileserver_openssh_image_name = var.fileserver_openssh_image_name
    fileserver_nginx_image_name   = var.fileserver_nginx_image_name
    fileserver_nginx_domain       = var.fileserver_nginx_domain
    fileserver_route_prefix       = var.fileserver_route_prefix
    fileserver_ssh_pub_key        = module.swarm.public_key_openssh
    fileserver_ssh_username       = var.fileserver_ssh_username
    fileserver_ssh_domain         = var.fileserver_ssh_domain
  }

  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      var.fileserver_output_file,
      local.fileserver_content
    )
  }
}