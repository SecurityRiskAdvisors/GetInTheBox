output "primary_manager_pub_ip" {
  value = module.swarm.primary_manager_node_ip
}

output "secondary_manager_pub_ips" {
  value = module.swarm.secondary_manager_node_ips
}

output "worker_pub_ips" {
  value = module.swarm.worker_node_ips
}

output "traefik_ui_password" {
    sensitive = true
    value = var.enable_traefik ? random_password.admin_password_traefik.result : ""
}

output "portainer_ui_password" {
    sensitive = true
    value = var.enable_portainer ? random_password.admin_password_portainer.result : ""
}

output "cs_password" {
    sensitive = true
    value = var.enable_cs ? random_password.admin_password_cobaltstrike.result : ""
}