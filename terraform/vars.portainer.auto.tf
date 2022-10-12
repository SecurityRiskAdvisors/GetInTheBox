variable "enable_portainer" {
    type = bool
    default = false
}

variable "portainer_output_file" {
  type = string
  default = "../swarm/generated/portainer.yaml"
}

variable "portainer_image_name" {
    type = string
    description = "Container image name for the Portainer service"
    default = "portainer/portainer-ce:2.15.1"
}

variable "portainer_agent_image_name" {
    type = string
    description = "Container image name for the Portainer agent"
    default = "portainer/agent:2.15.1"
}

variable "portainer_ui_domain" {
    type = string
    description = "Domain for the Portainer UI"
}