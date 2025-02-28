terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  project = "project01"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }

}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}


# create 4 ec2 instances in the subnet
resource "aws_instance" "main" {
  for_each = var.ec2_map
  # we will get the key and value from the ec2_map

  ami           = each.value.ami
  instance_type = each.value.instance_type


  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.main))
  #0 % 2 = 0
  #1 % 2 = 1
  #2 % 2 = 0 
  #3 % 2 = 1
  # % 2 is used to make sure that the instances are created in the 2 subnets


  tags = {
    Name = "${local.project}-instance-${each.key}"
  }

}

output "aws_subnet_id" {
  value = aws_subnet.main[*].id # [*] is used to get all the values
}
