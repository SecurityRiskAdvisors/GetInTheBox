variable "enable_fileserver" {
    type = bool
    default = false
}

variable "fileserver_output_file" {
  type = string
  default = "../swarm/generated/fileserver.yaml"
}

variable "fileserver_openssh_image_name" {
    type = string
    description = "Container image name for the fileserver's OpenSSH service"
    default = "linuxserver/openssh-server:latest"
}

variable "fileserver_nginx_image_name" {
    type = string
    description = "Container image name for the fileserver's nginx service"
    default = "nginx:1.23.1"
}

variable "fileserver_nginx_domain" {
    type = string
    description = "Domain for the fileservice's nginx service"
}

variable "fileserver_ssh_domain" {
    type = string
    description = "Domain for the fileservice's scp/ssh service"
}

variable "fileserver_route_prefix" {
    type = string
    description = "Route prefix for all nginx-hosted content"
    default = "/static"
}

variable "fileserver_ssh_username" {
    type = string
    description = "Username for the OpenSSH service"
}