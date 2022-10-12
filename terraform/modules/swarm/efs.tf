resource "aws_kms_key" "swarm_data_encryption" {
  description             = "Encrypt swarm data EFS"
  deletion_window_in_days = 10
}

resource "aws_efs_file_system" "swarm_data" {
  tags = {
    Name    = format("%s - Swarm data", var.project)
    Project = var.project
  }

  # cannot have both configs in a single `lifecycle_policy` block
  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  encrypted  = true
  kms_key_id = aws_kms_key.swarm_data_encryption.arn
}

resource "aws_efs_mount_target" "swarm_data" {
  file_system_id  = aws_efs_file_system.swarm_data.id
  subnet_id       = aws_subnet.primary.id
  security_groups = [aws_security_group.swarm_sg.id]
}

data "aws_network_interface" "efs_nic" {
    id = aws_efs_mount_target.swarm_data.network_interface_id
}