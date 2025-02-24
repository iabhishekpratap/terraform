terraform {

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.86.1"
        }
    }
}

provider "aws" {
    region = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
}

#private subnet
resource "aws_subnet" "private-subnet" {
    vpc_id                  = aws_vpc.my-vpc.id
    cidr_block              = "10.0.1.0/24"
    tags = {
        Name = "private-subnet"
    }
}

#public subnet
resource "aws_subnet" "public-subnet" {
    vpc_id                  = aws_vpc.my-vpc.id
    cidr_block              = "10.0.2.0/24"
    tags = {
        Name = "public-subnet"
    }
}

#internet gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-igw"
    }
}

#route table
resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id  
    }
}

#associate route table with subnet
resource "aws_route_table_association" "public-sub" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.my-rt.id
}

# launch instance in public subnet
resource "aws_instance" "myserver" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.nano"
    subnet_id = aws_subnet.public-subnet.id
    tags = {
        Name = "myserver"
    }
}

