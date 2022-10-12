variable "root_domain" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "ip_addresses" {
  type = list(string)
}

/*
variable "root_cname_record" {
  type    = string
  default = "www.microsoft.com"
}

variable "cname_records" {
  type    = list(string)
  default = []
}
*/