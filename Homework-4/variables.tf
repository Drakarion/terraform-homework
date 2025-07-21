variable "vpcs" {
  type = list(object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  }))
}

variable "subnets" {
    type = list(object({
        cidr_block = string
        availability_zone = string
        auto_assign_ip = bool
        name = string
    }))
}

variable "igw_name" {
  type = string
}

variable "route_table_names" {
  type = list(string)
}

variable "ports" {
  type = list(number)
}

variable "ec2_config" {
  type = map(string)
}