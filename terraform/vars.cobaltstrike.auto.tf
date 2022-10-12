variable "enable_cs" {
    type = bool
    default = false
}

variable "cs_output_file" {
  type = string
  default = "../swarm/generated/cobaltstrike.yaml"
}

variable "cs_image_name" {
    type = string
    description = "Container image name for cobaltstrike"
}

variable "cs_license" {
    type = string
    description = "License key for cobaltstrike"
}

variable "cs_expire_date" {
    type = string
    description = "Expiration date for cobaltstrike payloads"
}

variable "cs_profile" {
    type = string
    description = "Name of the provided cobaltstrike profile"
}

variable "cs_profile_domains" {
    type = list(string)
    description = "List of c2 domains that will be used for cobaltstrike"
}

variable "cs_profile_paths" {
    type = list(string)
    description = "List of uri paths that will be used for cobaltstrike"
}

variable "cs_profile_ua" {
    type = string
    description = "User agent that will be used for cobaltstrike"
}

variable "cs_teamserver_domain" {
    type = string
    description = "Domain for accessing CS Teamserver"
}