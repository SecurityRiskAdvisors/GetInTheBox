variable "ami_id" {
  type    = string
  default = ""
}

variable "project" {
  type = string
}

variable "ingress_ip_cidrs" {
  type = list(string)
}

variable "num_managers" {
  type = number
  validation {
    condition     = var.num_managers > 0
    error_message = "Must have at least one manager node."
  }
}

variable "num_workers" {
  type = number
  validation {
    condition     = var.num_workers >= 0
    error_message = "Number of workers must be non-negative."
  }
}
