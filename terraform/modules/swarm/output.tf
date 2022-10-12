output "private_key_pem" {
  value = tls_private_key.ssh_key.private_key_pem
}

output "public_key_pem" {
  value = tls_private_key.ssh_key.public_key_pem
}

output "private_key_openssh" {
    value = tls_private_key.ssh_key.private_key_openssh
}

output "public_key_openssh" {
    value = tls_private_key.ssh_key.public_key_openssh
}

output "ssh_key_file" {
    value = local_file.ssh_key_file.filename
}

output "primary_manager_node_ip" {
    value = aws_instance.primary_manager.public_ip
}

output "secondary_manager_node_ips" {
    value = aws_instance.secondary_manager[*].public_ip
}

output "worker_node_ips" {
    value = aws_instance.worker[*].public_ip
}