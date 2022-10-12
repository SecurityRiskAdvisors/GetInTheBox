locals {
  init_primary_manager_content = format("#!/bin/bash\n%s\n%s\n%s",
    file("${path.module}/base_templates/awsnix_install_docker.tftpl"),
    file("${path.module}/base_templates/awsnix_mount_efs.tftpl"),
    file("${path.module}/base_templates/awsnix_swarm_init.tftpl")
  )

  init_secondary_manager_content = format("#!/bin/bash\n%s\n%s\n%s",
    file("${path.module}/base_templates/awsnix_install_docker.tftpl"),
    file("${path.module}/base_templates/awsnix_mount_efs.tftpl"),
    file("${path.module}/base_templates/manager_join.tftpl")
  )

  init_worker_content = format("#!/bin/bash\n%s\n%s\n%s",
    file("${path.module}/base_templates/awsnix_install_docker.tftpl"),
    file("${path.module}/base_templates/awsnix_mount_efs.tftpl"),
    file("${path.module}/base_templates/worker_join.tftpl")
  )
}

resource "null_resource" "init_primary_manager_content" {
  triggers = {
    template = local.init_primary_manager_content
  }

  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.root}/modules/swarm_user_data/generated/init_primary_manager.tftpl",
      local.init_primary_manager_content
    )
  }
}

resource "null_resource" "init_secondary_manager_content" {
  triggers = {
    template = local.init_secondary_manager_content
  }

  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.root}/modules/swarm_user_data/generated/init_secondary_manager.tftpl",
      local.init_secondary_manager_content
    )
  }
}

resource "null_resource" "init_worker_content" {
  triggers = {
    template = local.init_worker_content
  }

  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${path.root}/modules/swarm_user_data/generated/init_worker.tftpl",
      local.init_worker_content
    )
  }
}