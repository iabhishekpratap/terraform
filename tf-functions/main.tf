terraform {
}

locals {
    value ="hello world"
}

variable "string_list" {
    type = list(string)
    default = [ "server1", "server2", "server3"]
  
}

output "output" {
    # value = local.value #value = lower(local.name)
    # value = startswith(local.name, "Hello")
    # value = join("-", var.list)
    # value = split("-", var.string)
    # value = trimspace(var.string)
    # value = length(var.list)
    # value = merge(var.map1, var.map2)
    # value = contains(var.list, "d")
    # value = max(1, 2, 3) and min(1, 2, 3)
    # value = abs(var.number)
    # value = toset(var.list) #to convert list into set (will remove the duplicates)
    value = tolist(var.string_list) #to convert set into list

}
