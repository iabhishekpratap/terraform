resource "aws_vpc" "name" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.name
  }

}

resource "aws_subnet" "name" {
  vpc_id   = aws_vpc.name.id
  for_each = var.subnet_config #key={cidr_block,availability_zone}

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    name = "${var.vpc_config.name}-subnet-${each.key}"
  }
}

locals {
  public_subnets = {
    for key, config in var.subnet_config : key => config if config.public == true
  }

  private_subnets = {
    for key, config in var.subnet_config : key => config if config.public == false
  }

}


# internet gateway
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  count  = length(local.public_subnets) > 0 ? 1 : 0
  tags = {
    Name = "${var.vpc_config.name}-ig"
  }
}

# route table
resource "aws_route_table" "name" {
  count  = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name[0].id
  }
  tags = {
    Name = "${var.vpc_config.name}-rt"
  }

}

# route table association
resource "aws_route_table_association" "name" {
  for_each       = local.public_subnets
  subnet_id      = aws_subnet.name[each.key].id
  route_table_id = aws_route_table.name[0].id
}
