output "init_primary_manager" {
  value = "${path.root}/modules/swarm_user_data/generated/init_primary_manager.tftpl"
}

output "init_secondary_manager" {
  value = "${path.root}/modules/swarm_user_data/generated/init_secondary_manager.tftpl"
}

output "init_worker" {
  value = "${path.root}/modules/swarm_user_data/generated/init_worker.tftpl"
}