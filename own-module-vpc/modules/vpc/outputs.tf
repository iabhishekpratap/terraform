#vpc
output "vpc_id" {
  value = aws_vpc.name.id
}

locals {
  public = {
    for key, config in local.public_subnets : key => {
      id                = aws_subnet.name[key].id
      availability_zone = config.availability_zone
    }
  }

  private = {
    for key, config in local.private_subnets : key => {
      id                = aws_subnet.name[key].id
      availability_zone = config.availability_zone
    }
  }
}


output "public_subnets" {
  value = local.public_subnets
}
output "private_subnets" {
  value = local.private_subnets

}
