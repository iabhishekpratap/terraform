variable "vpc_config" {
  description = "cidr and name of the vpc "
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "cidr block should be in valid format"
  }

}

variable "subnet_config" {
  description = "subnet configuration"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public =optional(bool,false)
    
  }))

  validation {
    condition     = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "cidr should be valid"
  }
}



