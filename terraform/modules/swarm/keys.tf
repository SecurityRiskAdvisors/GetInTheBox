##
# EC2 SSH Key
##
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "[${var.project}] Red Swarm key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ssh_key_file" {
  filename        = "${path.root}/${var.project}.pem"
  content         = tls_private_key.ssh_key.private_key_openssh
  file_permission = "0400"
}

#resource "aws_secretsmanager_secret" "ssh_key" {
#  name                    = "${var.project}/red_swarm_key"
#  recovery_window_in_days = 0
#}

#resource "aws_secretsmanager_secret_version" "ssh_key" {
#  secret_id     = aws_secretsmanager_secret.ssh_key.id
#  secret_string = tls_private_key.ssh_key.private_key_pem
#}

##
# EBS KMS Key
##

/* TODO: EBS encryption
resource "aws_kms_key" "ebs_key" {
  description             = "[${var.project}] Red Swarm EBS Key"
  deletion_window_in_days = 7
  policy = data.aws_iam_policy_document.ebs_policy.json
}
*/