## Terraform AWS VPC Module

## Overview

This Terraform module creates a customizable AWS Virtual Private Cloud (VPC) with user-defined subnets and networking components. The module allows users to specify CIDR blocks, availability zones, and subnet types (public or private). Public subnets are automatically associated with an Internet Gateway (IGW) and a routing table.

## Features

Accepts a CIDR block from the user to create a VPC.
Allows the creation of multiple subnets.
Accepts user-defined CIDR blocks for subnets.
Supports specifying Availability Zones (AZs) for subnets.
Allows marking subnets as public (default is private).
Automatically creates an Internet Gateway (IGW) for public subnets.
Associates public subnets with a routing table.

## Usage

```
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_config = {
    name       = "my-vpc"
    cidr_block = "10.0.0.0/16"


  }
  subnet_config = {
    public1 = {
      cidr_block        = "10.0.0.0/24"
      availability_zone = "ap-south-1a"
      public            = true
    }

    public2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-south-1c"
      public            = true
    }

    private = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-south-1b"
    }
  }

}

```
