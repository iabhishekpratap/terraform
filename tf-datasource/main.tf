terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">=5.86.1"
        }
    }
}

provider "aws" {
    region = "ap-south-1"
}

data "aws_availability_zones" "available" {
    state = "avialable"
}
output "aws_aviability_zones" {
    value = data.aws_availability_zones.available.names
}
resource "aws_instance" "sample-server" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"

    tags = {
        Name = "sample-server"
    }
}