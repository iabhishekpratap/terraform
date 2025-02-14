


#Terraform Block
terraform {

    required_providers {
    aws = {

        source = "hashicorp/aws"
        version = "5.86.1"
    }

    }
}

#Provider Block
provider "aws" {
    region = var.region
# Configuration options
}

#Resource Block
resource "aws_instance" "myserver" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.nano"

    tags = {
        Name = "myserver"
    }
}




