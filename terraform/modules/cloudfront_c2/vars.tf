variable "project" {
    type = string
    description = "Project name for labeling resources"
}

variable "num_distros" {
    type = number
    description = "Number of Cloudfront distributions to create"
    default = 1
}

variable "c2_domain" {
    type = string
    description = "The C2 domain pointing to your listener"
}

variable "c2_port" {
    type = number
    description = "The HTTPS ingress port for the C2 listener"
    default = 443
}