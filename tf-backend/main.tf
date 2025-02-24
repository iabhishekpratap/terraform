
#Terraform Block
terraform {
    required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.86.1"
        }
    }

    backend "s3" {
        bucket = "my-demo-bucket-9977"
        key = "backend.tfstate"
        region = "ap-south-1"
    }

}


#Provider Block
provider "aws" {
    region = "ap-south-1"
}

#Resource Block
resource "aws_instance" "myserver" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"

    tags = {
        Name = "myserver"
    }
}
