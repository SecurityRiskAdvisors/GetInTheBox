variable "enable_traefik" {
    type = bool
    default = false
}

variable "traefik_output_file" {
    type = string
    description = "Location for the generated Traefik Docker compose file"
    default = "../swarm/generated/traefik.yaml"
}

variable "traefik_image_name" {
    type = string
    description = "Container image name for Traefik"
    default = "traefik:v2.7"
}

variable "traefik_ui_domain" {
    type = string
    description = "Domain to server the Traefik UI interface over"
}