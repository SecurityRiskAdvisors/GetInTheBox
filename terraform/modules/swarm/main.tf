##
# EC2 nodes
#   migrate these into their own module. if anything
#   this will declutter the EBS config
##

# user data for EC2 initialization
module "swarm_user_data" {
  source = "../swarm_user_data"
}

# dynamically pull the latest Amazon Linux 2 AMI ID
# https://www.hashicorp.com/blog/hashicorp-terraform-supports-amazon-linux-2
data "aws_ami" "amazon_linux_2" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ami" "ubuntu20" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "primary_manager" {
  # force a "depends_on" so that we can mount the
  # EFS vol via cloud init
  depends_on = [
    aws_efs_mount_target.swarm_data
  ]

  tags = {
    Name = "[${var.project}] Red Swarm - Manager node 0"
  }

  ami                         = coalesce(var.ami_id, data.aws_ami.amazon_linux_2.id)
  instance_type               = "t3.small"
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.primary.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.swarm_sg.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = false // TODO: EBS encryption
    volume_size           = 8
    volume_type           = "gp3"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    delete_on_termination = true
    encrypted             = false // TODO: EBS encryption
    volume_size           = 20
    volume_type           = "gp3"
  }

  user_data = templatefile(module.swarm_user_data.init_primary_manager, { module_path = path.module, local_mount_location = "/opt/redswarm", efs_mount_location = aws_efs_file_system.swarm_data.dns_name })

  provisioner "remote-exec" {
    inline = [
      "sudo cloud-init status --wait"
    ]
  }

  connection {
   host        = coalesce(self.public_ip, self.private_ip)
   agent       = false
   type        = "ssh"
   user        = "ec2-user"
   private_key = file(local_file.ssh_key_file.filename)
  }
}

resource "aws_instance" "secondary_manager" {
  count = var.num_managers - 1
  depends_on = [
    aws_efs_mount_target.swarm_data
  ]

  tags = {
    Name = "[${var.project}] Red Swarm - Manager node ${count.index + 1}"
  }

  ami                         = coalesce(var.ami_id, data.aws_ami.amazon_linux_2.id)
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.primary.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.swarm_sg.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = false // TODO: EBS encryption
    volume_size           = 8
    volume_type           = "gp3"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    delete_on_termination = true
    encrypted             = false // TODO: EBS encryption
    volume_size           = 20
    volume_type           = "gp3"
  }

  user_data = templatefile(module.swarm_user_data.init_secondary_manager, { module_path = path.module, local_mount_location = "/opt/redswarm", efs_mount_location = aws_efs_file_system.swarm_data.dns_name })

  provisioner "remote-exec" {
    inline = [
      "sudo cloud-init status --wait"
    ]
  }

  connection {
   host        = coalesce(self.public_ip, self.private_ip)
   agent       = false
   type        = "ssh"
   user        = "ec2-user"
   private_key = file(local_file.ssh_key_file.filename)
  }
}

resource "aws_instance" "worker" {
  count = var.num_workers
  depends_on = [
    aws_efs_mount_target.swarm_data
  ]

  tags = {
    Name = "[${var.project}] Red Swarm - Worker node ${count.index}"
  }

  ami                         = coalesce(var.ami_id, data.aws_ami.amazon_linux_2.id)
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.primary.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.swarm_sg.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = false // TODO: EBS encryption
    volume_size           = 8
    volume_type           = "gp3"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    delete_on_termination = true
    encrypted             = false // TODO: EBS encryption
    volume_size           = 20
    volume_type           = "gp3"
  }

  user_data = templatefile(module.swarm_user_data.init_worker, { module_path = path.module, local_mount_location = "/opt/redswarm", efs_mount_location = aws_efs_file_system.swarm_data.dns_name })

  provisioner "remote-exec" {
    inline = [
      "sudo cloud-init status --wait"
    ]
  }

  connection {
   host        = coalesce(self.public_ip, self.private_ip)
   agent       = false
   type        = "ssh"
   user        = "ec2-user"
   private_key = file(local_file.ssh_key_file.filename)
  }
}
