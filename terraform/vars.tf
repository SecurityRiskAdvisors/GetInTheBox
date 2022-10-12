variable "project" {
    type = string
    description = "Project name for labeling resources"
    default = "Red Swarm"
    validation {
      condition = can(regex("^[a-zA-Z0-9\\-]+$", var.project))
      error_message = "Project name can only consist of alphanumerics and dashes."
    }
}

variable "cloudflare_email" {
    type = string
    description = "Email associated with your Cloudflare API key"
}

variable "cloudflare_api_key" {
    type = string
    default = "" # in case cloudflare isn't used, don't force the user to provide an API key
    description = "Your Cloudflare API key"
}

variable "ingress_ip_cidrs" {
    type = list(string)
    description = "List of IPs -- used for secgroups tied to VPN instances."
}

variable "num_managers" {
    type = number
    description = "Number of swarm manager nodes"
    default = 1
}

variable "num_workers" {
    type = number
    description = "Number of swarm worker nodes"
    default = 1
}


variable "root_domain" {
    type = string
    description = "The root domain for all deployed services"
}
